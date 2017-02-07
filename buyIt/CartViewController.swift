//
//  CartViewController.swift
//  buyIt
//
//  Copyright © 2017 zoocre8ive. All rights reserved.
//

import UIKit
protocol CartViewControllerCellDelegate {
    func updateDashboardUI()
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BICartTableViewCellDelegate {

    @IBOutlet var lblEmptyCart: UILabel!
    @IBOutlet var lblTotalCartProduct: UILabel!
    @IBOutlet var tblCartList: UITableView!
    @IBOutlet var lblTotalAmount: UILabel!
    var delegate: CartViewControllerCellDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if StockData.sharedInstance.getTotalSoldProductCount() > 0{
            lblEmptyCart.isHidden = true
        }else{
            lblEmptyCart.isHidden = false
        }
        lblTotalAmount.text = "$ \(StockData.sharedInstance.getTotalAmount())"
        if StockData.sharedInstance.getTotalSoldProductCount() > 1{
            self.lblTotalCartProduct.text = "\(StockData.sharedInstance.getTotalSoldProductCount()) items in your cart"
        }else
        {
            self.lblTotalCartProduct.text = "\(StockData.sharedInstance.getTotalSoldProductCount()) item in your cart"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StockData.sharedInstance.arrayProductStock.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell.cart") as! BICartTableViewCell
        let objProduct = StockData.sharedInstance.arrayProductStock.object(at: indexPath.row) as! ProductModel
        cell.setCellWithData(objProduct: objProduct)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let objProduct = StockData.sharedInstance.arrayProductStock.object(at: indexPath.row) as! ProductModel
        if(objProduct.soldProduct == 0){
            return 0
        }
        else{
            return 110
        }
    }
    //MARK: - BICartTableViewCellDelegate
    func didTapToDeleteProduct(objCell: BICartTableViewCell) {
        
        let indexForCell = self.tblCartList.indexPath(for: objCell)
        let objProduct = StockData.sharedInstance.arrayProductStock.object(at: (indexForCell?.row)!) as! ProductModel
        
        let alertController = UIAlertController(title: "\(objProduct.strProductName)", message: "Do you want remove the product from yuu cart?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) {
            UIAlertAction in
            objProduct.soldProduct = 0
            StockData.sharedInstance.arrayProductStock.replaceObject(at: (indexForCell?.row)!, with: objProduct)
            self.lblTotalAmount.text = "$ \(StockData.sharedInstance.getTotalAmount())"
            if StockData.sharedInstance.getTotalSoldProductCount() > 1{
                self.lblTotalCartProduct.text = "\(StockData.sharedInstance.getTotalSoldProductCount()) items in your cart"
            }else
            {
                self.lblTotalCartProduct.text = "\(StockData.sharedInstance.getTotalSoldProductCount()) item in your cart"
            }
            self.delegate?.updateDashboardUI()
            
            if StockData.sharedInstance.getTotalSoldProductCount() > 0{
                self.lblEmptyCart.isHidden = true
            }else{
                self.lblEmptyCart.isHidden = false
            }
            self.tblCartList.reloadData()

        }
        let cancelAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnCloseModalAction(_ sender: Any) {
        delegate?.updateDashboardUI()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCheckOutAction(_ sender: Any) {
        let alert = UIAlertController(title: "Buy It", message: "Comming soon", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
