//
//  AppConstants.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 02/06/25.
//

import Foundation

enum AppConstants : String{
    case url  = "https://warp-wiry-rugby.glitch.me/orders"
}
enum httpMethods: String{
    case get = "GET"
    case post = "POST"
}
enum NetWorkError : Error{
    case decoding
    case domain
    case url
}
enum Identifiers : String{
    case addOrderCell = "AddOrderCell"
    case orderTableViewCell = "OrderTableVIewCell"
}

enum ErrorOutput : String {
    case noOrder = "No order"
    case typeSelection = "Error selecting type"
    case encodeError = "Error encoding JSON"
    case parseError = "Error parsing URL"
    case structError = "Error in model"
    case 
}
