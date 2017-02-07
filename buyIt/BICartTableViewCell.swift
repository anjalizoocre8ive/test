//
//  BICartTableViewCell.swift
//  buyIt
//
//  Copyright © 2017 zoocre8ive. All rights reserved.
//

import UIKit
protocol BICartTableViewCellDelegate {
    func didTapToDeleteProduct(objCell: BICartTableViewCell)
}

class BICartTableViewCell: UITableViewCell {

    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblProductDescription: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    var delegate: BICartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - Custom Method
    func setCellWithData(objProduct: ProductModel) {
        lblProductName.text = objProduct.strProductName;
        lblPrice.text = "\(objProduct.soldProduct) x $\(objProduct.price)"
    }

    
    @IBAction func btnDeleteProductAction(_ sender: Any) {
        delegate?.didTapToDeleteProduct(objCell: self)
    }
}
