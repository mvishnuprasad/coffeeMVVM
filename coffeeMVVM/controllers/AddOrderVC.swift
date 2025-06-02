//
//  AddOrderVC.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//

import Foundation
import UIKit
class AddOrderVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    private var coffeSizeSegmentedControl : UISegmentedControl!
    private var vm = AddOrderVM()
    
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddOrderCell", for : indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none

    }
    
    @IBAction func save(){
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let size = self.coffeSizeSegmentedControl.titleForSegment(at: self.coffeSizeSegmentedControl.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow else{
            fatalError("Error selecting")
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = size
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        WebService().load(resourse: Orders.create(vm: self.vm)){result in
            switch result {
            case .success(let orders):
//                self?.orderListVM.ordersVM = orders.map { order in
//                  
//                    OrderViewModel(order: order)
//                }
               
//                self?.tableView.reloadData()
            case .failure(let err):
                print(err)
            }
        }
    }
}
