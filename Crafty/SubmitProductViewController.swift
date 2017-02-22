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
    
    var product: Product!
    
    let dataSource = SubmitProductDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        product = Product()
        
        setupNavigationBar(title: "Your Product")
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.tableFooterView = UIView() // hide empty cell
        productImage1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProductImages)))
        productImage1.isUserInteractionEnabled = true
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        tableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceTableViewCell")
        tableView.register(UINib(nibName: "DeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliveryTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateCategoryDetail), name: Notification.Name(rawValue: "shareCategory"), object: nil)
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
        
        product.toString()
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "categorySegue" {
    //            let vc = segue.destination as! CategoryViewController
    //            vc.deleg
    //        }
    //    }
    
    //    func submitItemToDatabase() {
    //        guard let name = nameTxt.text, let detail = detailTxt.text, let price = Double(priceTxt.text!), let category = categoryTxt.text, let selfCollect: Bool = selfCollectSwitch.isOn else { return }
    //
    //
    //        let sellerId = FIRAuth.auth()?.currentUser?.uid
    //        let ref = FIRDatabase.database().reference().child("products")
    //        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
    //        let values: [String: AnyObject] = ["name": name as AnyObject, "detail": detail as AnyObject, "price": price as AnyObject, "selfCollect": selfCollect as AnyObject, "category": category as AnyObject, "timestamp": timestamp, "sellerId": sellerId as AnyObject]
    //
    //        let childRef = ref.childByAutoId()
    //
    //        childRef.updateChildValues(values) { (error, ref) in
    //            if error != nil {
    //                print(error!)
    //                return
    //            }
    //
    //        }
    //    }
    
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
            print("Error pushing view controller")
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
