//
//  BIDashBoardTableViewCell.swift
//  buyIt
//
//  Copyright © 2017 zoocre8ive. All rights reserved.
//

import UIKit
protocol BIDashBoardTableViewCellDelegate {
    func didTapToBuyItem(objCell: BIDashBoardTableViewCell)
}

class BIDashBoardTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblStock: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    //MARK: - Properties
    var delegate: BIDashBoardTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: IBAction
    @IBAction func btnBuyAction(_ sender: Any) {
        delegate?.didTapToBuyItem(objCell: self)
    }
    //MARK: - Custom Method
    func setCellWithData(objProduct: ProductModel) {
        lblName.text = objProduct.strProductName;
        lblPrice.text = "$ \(objProduct.price)"
        lblStock.text = "Stock: \(objProduct.stockAmnt - objProduct.soldProduct)"
    }
}
