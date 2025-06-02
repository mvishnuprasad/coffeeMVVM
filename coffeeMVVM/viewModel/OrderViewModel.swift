//
//  OrderViewModel.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//
 
import Foundation

struct OrderViewModel{
    let order : Orders
    var name : String {
        return self.order.name
    }
    var email : String {
        return self.order.email
    }
    var type : String {
        return self.order.type.rawValue
    }
    var size : String {
        return self.order.size.rawValue
    }
}

class OrdersListVM{
    ///array of all orders
    var ordersVM : [OrderViewModel]
    init() {
        self.ordersVM = [OrderViewModel]()
    }
//    func orderVM (at index: Int)->OrderViewModel{
//        return self.ordersVM[index]
//    }
}
