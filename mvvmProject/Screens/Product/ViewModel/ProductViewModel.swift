//
//  ProductView.swift
//  mvvmProject
//
//  Created by Preeti Kesarwani on 10/6/23.
//

import Foundation



final class ProductViewModel {
    
    var product : [Product] = []
    var eventHandler :((_ event : Event) -> Void)? // DATA BINDING
    
    func fetchProducts(){
        
        self.eventHandler?(.loading)
        APIManager.shared.request(modelType: [Product].self,
                                  type: EndPointItems.produts) { response in
            
            self.eventHandler?(.loading)
            switch response {
            case .success(let products):
                self.product = products
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
            
            
        }
        
    }
    
    func addProduct(parameters  : AddProduct){
        APIManager.shared.request(modelType: AddProduct.self,
                                  type: EndPointItems.addproduct(product: parameters)) { result in
            switch result {
            case.success(let product):
                self.eventHandler?(.newProductAdd(Product: product))
            case.failure(let error):
                self.eventHandler!(.error(error))
            }
        }
        
    }
}
    extension ProductViewModel {
        enum Event {
            case loading
            case stopLoading
            case dataLoaded
            case error(Error?)
            case newProductAdd(Product : AddProduct)
            
        }
        
    }

