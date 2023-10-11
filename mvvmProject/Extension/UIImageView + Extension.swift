//
//  UIImageView + Extension.swift
//  mvvmProject
//
//  Created by Preeti Kesarwani on 10/9/23.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    func setImage(with urlSring : String){
        guard let url = URL.init(string: urlSring) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlSring)
        
        kf.indicatorType = .activity
        kf.setImage(with: resource)
        
    }
}
