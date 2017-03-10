//
//  SubmitItemViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/3/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase
import ImagePicker

class SubmitProductViewController: UIViewController, ImagePickerDelegate, UINavigationControllerDelegate, SetupNavBar {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var productImage1: UIImageView!
    @IBOutlet weak var productImage2: UIImageView!
    @IBOutlet weak var productImage3: UIImageView!
    @IBOutlet var imageCollection: [UIImageView]!
    
    @IBOutlet weak var leftImageContraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageContraint: NSLayoutConstraint!
    
    var product: Product!
    
    let dataSource = SubmitProductDataSource()
    let nf = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        product = Product()
        
        self.setupNavigationBar(title: "Sell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmitProduct))
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.tableFooterView = UIView() // hide empty cell
        productImage1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProductImages)))
        productImage1.isUserInteractionEnabled = true
        
        tableView.register(CategoryTableViewCell.self)
        tableView.register(ItemTableViewCell.self)
        tableView.register(PriceTableViewCell.self)
        tableView.register(DeliveryTableViewCell.self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateCategoryDetail), name: Notification.Name(rawValue: "shareCategoryDetail"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateCategory), name: Notification.Name(rawValue: "shareCategory"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateItemDetail), name: Notification.Name(rawValue: "shareItem"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateDelivery), name: Notification.Name(rawValue: "shareDelivery"), object: nil)
        
        checkSubmitCondition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setup()
        self.navigationItem.changeTitleView(width: self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height)
    }
    
    func handleSubmitProduct() {
        let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! PriceTableViewCell
        product.price = Double(cell.priceTextField.text!) as NSNumber?
        
        FirebaseManager.handleSubmitProductInfo(product: product, images: imageCollection, viewController: self) {
            self.resetAfterSubmit()
        }
        
    }
    
    func resetAfterSubmit() {
        imageCollection.forEach {
            $0.image = UIImage(named: "takePhoto")
            resetImageShadow(image: $0)
        }
        
        UIView.animate(withDuration: 0.7) {
            self.rightImageContraint.constant = 130
            self.leftImageContraint.constant = 130
            self.view.layoutIfNeeded()
        }
        
        let categoryCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CategoryTableViewCell
        categoryCell?.categoryDetail.text = "Choose one"
        
        let itemCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ItemTableViewCell
        itemCell?.itemDetail.text = "Describe your item"
        
        let priceCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? PriceTableViewCell
        priceCell?.priceTextField.placeholder = "VND 0.00"
        priceCell?.priceTextField.text = ""
        priceCell?.priceTextField.resignFirstResponder()
        
        let deliveryCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? DeliveryTableViewCell
        deliveryCell?.deliveryDetail.text = "Meet-up or Delivery"
        
        product.resetAll()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension SubmitProductViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Lato-Bold", size: 13)
        header.textLabel?.textColor = Color.darkPurple
        header.backgroundColor = Color.background
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryVC") as? CategoryViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ItemVC") as? ItemViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        case 3:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DeliveryVC") as? DeliveryViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            print("not pushing to any VC")
        }
    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
    //        view.textLabel?.font = UIFont(name: "Lato-Bold", size: 13)
    //        view.textLabel?.textColor = Color.darkPurple
    //        view.backgroundColor
    //        return view
    //    }
    
}
