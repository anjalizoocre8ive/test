//
//  StockData.swift
//  buyIt
//
//  Copyright © 2017 zoocre8ive. All rights reserved.
//

import UIKit

class StockData: NSObject {
   static let sharedInstance = StockData()
    var arrayProductStock = NSMutableArray()
    override init() {

        for i in 1...20{
            let objPro = ProductModel.productWithIndex(index: i)
            arrayProductStock.add(objPro)
        }
    }
    func getTotalAmount() -> Double {
        var amount: Double = 0.0
        for i in 0..<arrayProductStock.count{
            let objPro = arrayProductStock.object(at: i) as! ProductModel
            amount +=  Double(objPro.soldProduct) * Double(objPro.price)
        }
        return amount
    }
    func getTotalSoldProductCount() -> Int {
        var soldCount: Int = 0
        for i in 0..<arrayProductStock.count{
            let objPro = arrayProductStock.object(at: i) as! ProductModel
            soldCount +=  objPro.soldProduct
        }
        return soldCount
    }
}
