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

class SubmitProductViewController: UIViewController, ImagePickerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var productImage1: UIImageView!
    @IBOutlet weak var productImage2: UIImageView!
    @IBOutlet weak var productImage3: UIImageView!
    @IBOutlet var imageCollection: [UIImageView]!
    
    @IBOutlet weak var leftImageContraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageContraint: NSLayoutConstraint!
    
    var product: Product!
    
    let dataSource = SubmitProductDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        product = Product()
        
        setupNavigationBar(title: "Sell")
        
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setup()
        self.navigationItem.changeTitleView(width: self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height)
    }
    
    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmitProduct))
    }
    
    func handleSubmitProduct() {
        let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! PriceTableViewCell
        product.price = Double(cell.priceTextField.text!)
        
        product.printAll()
        
        FirebaseManager.handleSubmitProduct(product: product, viewController: self)
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
