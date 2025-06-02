//
//  order.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//

import Foundation
enum CoffeeTypes: String,Codable,CaseIterable{
    case capuccino
    case latte
    case espresso
    case cortado
    case plainCofee
    
}
enum CoffeeSize : String, Codable,CaseIterable{
    case small
    case medium
    case large
}
struct Orders : Codable{
    let name: String
    let email: String
    let type: CoffeeTypes
    let size: CoffeeSize
    
}


extension Orders {
    /// Convert the single order type from AddOrderVM to a type of Orders
    init?(_ vm : AddOrderVM) throws {
        guard let name = vm.name,
              let email = vm.email,
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize?.lowercased() ?? ""),let selectedType = CoffeeTypes(rawValue: vm.selectedType?.lowercased() ?? "") else {
            return nil
        }
        self.email = email
        self.name = name
        self.type = selectedType
        self.size = selectedSize
    }
    static var all : Resource<[Orders]> = {
        guard let url = URL(string: AppConstants.url.rawValue) else {
            fatalError("Error")
        }
        return Resource<[Orders]>(url: url)
    }()
    static func create(vm: AddOrderVM) -> Resource<Orders?>{
        guard let order = try? Orders(vm) else{
            fatalError("Error")
        }
        
        guard let url = URL(string: AppConstants.url.rawValue) else {
            fatalError("Error")
        }
        guard let data = try? JSONEncoder().encode(order) else{
            fatalError("Error")
        }
        var resource  = Resource<Orders?>(url: url)
        resource.httpMethod = httpMethods.post
        resource.body = data
        return resource
    }
}
