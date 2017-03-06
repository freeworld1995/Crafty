//
//  DeliveryViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/18/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Lottie

class DeliveryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pinJumpContainer: UIView!
    
    var locationName: String?
    var locationAddress: String?
    
    var pinJumpView = LOTAnimationView()
    let datasource = DeliveryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Delivery")
        
        tableView.dataSource = datasource
        tableView.delegate = self
        
        datasource.fetchNearbyPlaces {
            self.addTopAnimation()

            self.tableView.reloadData()
        }
    }
    
    func addTopAnimation() {
        pinJumpView = LOTAnimationView(name: "PinJump")
        pinJumpView.frame = CGRect(x: pinJumpContainer.frame.width / 2 - 75, y: -pinJumpContainer.frame.height / 2 + 5, width: 150, height: 150)
        pinJumpView.contentMode = .scaleAspectFit
        pinJumpView.loopAnimation = true
        pinJumpView.alpha = 0.0
        pinJumpContainer.addSubview(pinJumpView)
        pinJumpView.play()
        UIView.animate(withDuration: 0.5, animations: {
            self.pinJumpView.alpha = 1.0
        })
    }
    
    func setupNavigationBar(title: String) {
        self.navigationController?.navigationBar.setup()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(backToCategoryVC))
    }
    
    func backToCategoryVC() {
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "shareDelivery"), object: nil, userInfo: ["locationName": locationName, "locationAddress": locationAddress])
    }
    
    deinit {
        print("DeliveryVC deinit")
    }
    
}

extension DeliveryViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! LocationTableViewCell
            cell.isSelected = true
            locationName = cell.textLabel?.text
            locationAddress = cell.detailTextLabel?.text
            
        }
    
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            tableView.cellForRow(at: indexPath)?.isSelected = false
        }
}
