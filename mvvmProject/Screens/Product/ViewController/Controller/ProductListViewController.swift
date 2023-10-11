//
//  ProductListViewController.swift
//  mvvmProject
//
//  Created by Preeti Kesarwani on 10/6/23.
//

import UIKit

class ProductListViewController: UIViewController {
  private  var viewModel = ProductViewModel()
    
   @IBOutlet weak var productTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
    }
    
    
    
    @IBAction func addProductButtonTapped(_ sender: UIBarButtonItem) {
       let product = AddProduct(title: "PREETI")
        viewModel.addProduct(parameters: product)
        print(product)
    }
    
    

}
extension ProductListViewController {
    func configuration(){
        initViewModel()
        observeEvent()
        productTableView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        
    }
    
    func initViewModel(){
        viewModel.fetchProducts()
    
        
    }
    // data binding
    func observeEvent(){
        // 'weak self' means = data (event) may be nil or not
        viewModel.eventHandler = {[weak self] event in
            guard let self else {return}
            switch event {
            case .loading:
                print("product loading....")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                print("data loding")
                print(self.viewModel.product)
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            case .newProductAdd(Product: let newproduct):
                print(newproduct)
            }
            
            
        }
        
    }
}
extension ProductListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.product.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as? ProductListCell else {
            
            
            return UITableViewCell()
        }
        let product = viewModel.product[indexPath.row]
        cell.product = product
        return cell
        
    }
}
