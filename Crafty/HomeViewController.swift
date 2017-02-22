//
//  HomeViewController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//try! FIRAuth.auth()?.signOut()
        checkIfUserIsLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }
    
    override func awakeFromNib() {
        self.navigationController?.navigationBar.setup()
        self.navigationItem.changeTitleView(width: self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height)
    }

    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
        }
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()!.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "registervc") as! RegisterViewController
        present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
