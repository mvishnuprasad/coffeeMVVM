//
//  AddOrderVC.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//

import Foundation
import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeVCDidSave(order: Orders, controller: UIViewController)
    func addCOffeeVCDidclose(controller: UIViewController)
}
class AddOrderVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    private var coffeSizeSegmentedControl : UISegmentedControl!
    private var vm = AddOrderVM()
    var delegate :AddCoffeeOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
        self.coffeSizeSegmentedControl = UISegmentedControl(items: self.vm.size)
        self.coffeSizeSegmentedControl.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(coffeSizeSegmentedControl)
        self.coffeSizeSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor,constant:-50).isActive = true
        self.coffeSizeSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.addOrderCell.rawValue, for : indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none

    }
    
    @IBAction func close() {
        if  let delegate = self.delegate{
            DispatchQueue.main.async{
                delegate.addCOffeeVCDidclose(controller: self)
            }
        }
    }
    
    @IBAction func save(){
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let size = self.coffeSizeSegmentedControl.titleForSegment(at: self.coffeSizeSegmentedControl.selectedSegmentIndex)
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else{
            fatalError(ErrorOutput.typeSelection.rawValue)
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = size
        self.vm.selectedType = self.vm.types[selectedIndexPath.row]
        /// Send post request with selected order body 
        WebService().load(resourse: Orders.create(vm: self.vm)){result in
            switch result {
            case .success(let orders):
                if let order = orders,let delegate = self.delegate{
                    DispatchQueue.main.async{
                        delegate.addCoffeeVCDidSave(order: order, controller: self)
                    }
                }else{
                    fatalError(ErrorOutput.noOrder.rawValue)
                }
              
            case .failure(let err):
                print(err)
            }
        }
    }
}
