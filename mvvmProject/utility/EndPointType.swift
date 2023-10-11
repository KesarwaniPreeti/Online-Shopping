//
//  EndPointType.swift
//  mvvmProject
//
//  Created by Preeti Kesarwani on 10/9/23.
//

import Foundation

struct AddProduct : Codable{
   
    let title : String
}

enum HTTPMethod : String {
    case get  = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path : String {get}
    var baseUrl : String {get}
    var url : URL? {get}
    var method : HTTPMethod{get}
    var body : Encodable? {get}
    var header : [String : String]?{get}
}
//   baseURL                 PATH
// https://fakestoreapi.com/products
enum EndPointItems{
    case produts//   modules means how many screen we have, like i have product screen
    case addproduct (product: AddProduct)
                                               
}


extension EndPointItems : EndPointType {
    
    var body: Encodable? {
        switch  self {
        case .produts:
            return nil
        case .addproduct(product: let product):
            return product
        }
    }
    
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
    var path: String {
        switch self {
        case .produts:
            return "products"
        case .addproduct(let product):
            return "products/add"
           
        }
       
    }
    
    var baseUrl: String {
        switch  self {
        case .produts:
             return "https://fakestoreapi.com/"
        case .addproduct :
            return "https://dummyjson.com/"
        }
        
      
    }
    
    var url: URL? {
      return  URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HTTPMethod {
        switch self {
        case .produts :
            
            return .get
        case .addproduct :
            return .post
 
        }
    }
    
    
}
