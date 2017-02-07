//
//  ViewController.swift
//  buyIt
//
//  Copyright © 2017 zoocre8ive. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BIDashBoardTableViewCellDelegate, CartViewControllerCellDelegate {

    @IBOutlet var tblProduct: UITableView!
    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var lblCartCount: UILabel!
    @IBOutlet var vwCartCount: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        StockData.sharedInstance
        lblTotalAmount.text = "$ \(StockData.sharedInstance.getTotalAmount())"
        lblCartCount.text = "\(StockData.sharedInstance.getTotalSoldProductCount())"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "goToCartView"{
            let objVC = segue.destination as! CartViewController
            objVC.delegate = self
        }
     }
 

    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StockData.sharedInstance.arrayProductStock.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell.dashBoard") as! BIDashBoardTableViewCell
        let objProduct = StockData.sharedInstance.arrayProductStock.object(at: indexPath.row) as! ProductModel
        cell.setCellWithData(objProduct: objProduct)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let objProduct = StockData.sharedInstance.arrayProductStock.object(at: indexPath.row) as! ProductModel
        if(objProduct.soldProduct == objProduct.stockAmnt){
            return 0
        }
        else{
            return 120
        }
    }
    
    //MARK: - BIDashBoardTableViewCellDelegate
    func didTapToBuyItem(objCell: BIDashBoardTableViewCell) {
        let indexForCell = tblProduct.indexPath(for: objCell)
        let objProduct = StockData.sharedInstance.arrayProductStock.object(at: (indexForCell?.row)!) as! ProductModel
        objProduct.soldProduct += 1
        StockData.sharedInstance.arrayProductStock.replaceObject(at: (indexForCell?.row)!, with: objProduct)
        lblTotalAmount.text = "Total Amount: $ \(StockData.sharedInstance.getTotalAmount())"
        lblCartCount.text = "\(StockData.sharedInstance.getTotalSoldProductCount())"
        tblProduct.reloadData()
    }
    //MARK: - CartViewControllerCellDelegate
    func updateDashboardUI() {
        lblCartCount.text = "\(StockData.sharedInstance.getTotalSoldProductCount())"
        lblTotalAmount.text = "Total Amount: $ \(StockData.sharedInstance.getTotalAmount())"
        tblProduct.reloadData()
    }
    //MARK: - IBAction
    
    @IBAction func btnViewCartAction(_ sender: Any) {
    }
}

