//
//  ProductModel.swift
//  buyIt
//
//  Copyright © 2017 zoocre8ive. All rights reserved.
//

import UIKit

class ProductModel: NSObject {

    var strProductName = ""
    var stockAmnt = 0
    var price = 0
    var soldProduct = 0
    
    
    class func productWithIndex(index: Int) -> ProductModel {
        let objProduct = ProductModel()
        objProduct.strProductName = "Product \(index)"
        objProduct.stockAmnt      = 10
        objProduct.price          = 5 * index
        objProduct.soldProduct    = 0
        return objProduct
    }

}
