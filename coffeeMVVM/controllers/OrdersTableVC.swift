//
//  OrdersTableVC.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//

import Foundation
import UIKit
class OrdersTableVC : UITableViewController , AddCoffeeOrderDelegate{
    func addCOffeeVCDidSave(order: Orders, controller: UIViewController) {
        controller.dismiss(animated: true)
        let ordersVM = OrderViewModel(order: order)
        self.orderListVM.ordersVM.append(ordersVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListVM.ordersVM.count-1, section: 0)], with: .automatic)
    }
    
    func addCOffeeVCDidclose(controller: UIViewController) {
        controller.dismiss(animated: true)
        
    }
    
    var orderListVM = OrdersListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrder()
    }
    private func populateOrder() {
        WebService().load(resourse: Orders.all){[weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListVM.ordersVM = orders.map { order in
                    OrderViewModel(order: order)
                }
                self?.tableView.reloadData()
            case .failure(let err):
                print(err)
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListVM.ordersVM.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = orderListVM.orderVM(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableVIewCell")
        cell?.textLabel?.text = vm.type
        cell?.detailTextLabel?.text = vm.size
        return cell!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,
              let addCoffeeOrderVC = nav.viewControllers.first as? AddOrderVC else{
            fatalError()
        }
        addCoffeeOrderVC.delegate = self
    }
}
