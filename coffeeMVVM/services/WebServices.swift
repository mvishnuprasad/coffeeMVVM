//
//  webservices.swift
//  coffeeMVVM
//
//  Created by vishnuprasad on 01/06/25.
//

import Foundation

class WebService{
    func load<T> (
        resourse: Resource<T>,
        completion : @escaping (Result<T,NetWorkError>)-> Void
    ) {
        var req  = URLRequest(url: resourse.url)
        req.httpMethod = resourse.httpMethod.rawValue
        req.httpBody = resourse.body
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("req is \(req)")
        URLSession.shared.dataTask(with: req) {data , response, error in
            guard let data = data , error == nil else{
                completion(.failure(.domain))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async{
                    completion(.success(result))
                }
            }else{
                completion(.failure(.decoding))
            }
        }.resume()
    }
}
