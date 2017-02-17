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

    
    let dataSource = SubmitProductDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.tableFooterView = UIView() // hide empty cell
        productImage1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProductImages)))
        productImage1.isUserInteractionEnabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setup()
        self.navigationItem.changeTitleView()
    }
    
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
    
    func handleSelectProductImages(gesture: UITapGestureRecognizer) {
        let picker = ImagePickerController()
        picker.imageLimit = 3
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("wrapper did press")
    }

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        for i in 0...2 {
            imageCollection[i].image = images[i]
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
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
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
//        view.textLabel?.font = UIFont(name: "Lato-Bold", size: 13)
//        view.textLabel?.textColor = Color.darkPurple
//        view.backgroundColor
//        return view
//    }
    
}
