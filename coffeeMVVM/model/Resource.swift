//
//  Resource.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 02/06/25.
//

import Foundation

struct Resource<T : Codable> {
    let url : URL
    var httpMethod : httpMethods = .get
    var body : Data? = nil
    init(url: URL ) {
        self.url = url
        
    }
}
