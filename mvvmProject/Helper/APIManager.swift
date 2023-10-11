//
//  APIManager.swift
//  mvvmProject
//
//  Created by Preeti Kesarwani on 10/6/23.
//

import Foundation



enum DataError : Error {
    case invaildResponse
    case invaildURL
    case invaildDecoding
    case message(_ error : Error?)
    case invaildData
}

//typealias handler = (Result<[Product], DataError>)-> Void

typealias handler<T> = (Result<T, DataError>)-> Void
final class APIManager {
    
    
    static let shared = APIManager()
    private init() {}
    
    func request<T : Codable>(
        modelType : T.Type ,// MODEL(Product)
        type : EndPointType,
        completion :@escaping handler<T>
    ){
        guard  let url = type.url else {
            completion(.failure(.invaildURL))
            return
            
        }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = type.method.rawValue
        
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = type.header
        
      URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.invaildData))
                return
                
            }
            
            guard let response = response as? HTTPURLResponse ,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invaildResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
                
            } catch {
                completion(.failure(.message(error)))
                
            }
            
        }.resume()
        
        
        
    }
    
    
}

