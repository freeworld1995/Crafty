//
//  RegisterController.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nameTextFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var registerToPassword: NSLayoutConstraint!
    @IBOutlet weak var registerToBottom: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var nameTxt: CustomTextField!
    @IBOutlet weak var emailTxt: CustomTextField!
    @IBOutlet weak var passwordTxt: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        
        setupKeyboardObservers()
        
        nameTxt.delegate = self
        emailTxt.delegate = self
        passwordTxt.delegate = self
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
    }
    
    @IBAction func textFieldTouched(_ sender: CustomTextField) {
        UIView.animate(withDuration: 0.7) { [unowned self] in
            self.scrollView.contentOffset = CGPoint(x: 0, y: sender.frame.origin.y - 200)
        }
    }
    
    @IBAction func LoginRegisterSegmentPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.registerButton.setTitle("Login", for: .normal)
                self.nameLabel.isHidden = true
                self.imageViewHeight.constant = 0
                self.nameTextFieldHeight.constant = 0
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.registerButton.setTitle("Register", for: .normal)
                self.nameLabel.isHidden = false
                self.imageViewHeight.constant = 85
                self.nameTextFieldHeight.constant = 51
                self.view.layoutIfNeeded()
            }
        }
    }
    

    
    @IBAction func registerPressed(_ sender: UIButton) {
        if segmentControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
}
