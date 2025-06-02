//
//  AddOrderVM.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//

import Foundation

struct AddOrderVM{
    var name: String?
    var email: String?
    var selectedSize: String?
    var selectedType: String?
    var types :[ String]{
        return CoffeeTypes.allCases.map{$0.rawValue.capitalized}
    }
    var size :[ String]{
        return CoffeeSize.allCases.map{$0.rawValue.capitalized}
    }
}
