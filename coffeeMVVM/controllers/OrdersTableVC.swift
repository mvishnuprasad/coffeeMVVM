//
//  OrdersTableVC.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//

import Foundation
import UIKit
class OrdersTableVC : UITableViewController {
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
}
