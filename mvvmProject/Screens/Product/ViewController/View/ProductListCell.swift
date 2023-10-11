//
//  ProductListCell.swift
//  mvvmProject
//
//  Created by Preeti Kesarwani on 10/7/23.
//

import UIKit

class ProductListCell: UITableViewCell {
    
    
    @IBOutlet var productBackGroundView: UIView!
    
    
    @IBOutlet var productTitleLabel: UILabel!
    
    @IBOutlet var ProductCategory: UILabel!
    
    @IBOutlet var rateButton: UIButton!
    
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    
    
    @IBOutlet var productImage: UIImageView!
    
    var product : Product? {
        didSet {
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIviewDesign()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration(){
        guard let product else {return}
        
        productTitleLabel.text = product.title
        ProductCategory.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImage.setImage(with: product.image)
        
        
    }
    func UIviewDesign(){
        productBackGroundView.clipsToBounds = false
        productBackGroundView.layer.cornerRadius = 15
        productImage.layer.cornerRadius = 10
        self.productBackGroundView.backgroundColor = .systemGray6
        
    }
}
