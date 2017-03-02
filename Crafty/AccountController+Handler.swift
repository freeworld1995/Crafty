//
//  AccountController+Handler.swift
//  Crafty
//
//  Created by Jimmy Hoang on 3/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension AccountViewController {
    func logout() {
        FirebaseManager.handleLogout()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "registervc") as?RegisterViewController
        present(vc!, animated: true, completion: nil)
    }
}
