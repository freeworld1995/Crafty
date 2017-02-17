//
//  RegisterController+Handler.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/2/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import Firebase

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    func handleSelectProfileImageView(gesture: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func handleLogin() {
        guard let email = emailTxt.text, let password = passwordTxt.text else { return }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            self.dismiss(animated: true)
        })
    }
    
    func handleRegister() {
        guard let name = nameTxt.text, let email = emailTxt.text, let password = passwordTxt.text else { return }
        
        // Tạo user - cần email, password
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let userUId = user?.uid else { return }
            
            // Tạo tên cho image ko bị trùng
            let imageName = UUID().uuidString
            
            // Tạo đường dẫn đến Storage | profile_images - imageName.png
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
            
            // Lấy image + chuyển nó sang Data / JPEG để 0.1 để nén ảnh
            if let profileImage = self.imageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    // Cho đc vào Storage rồi thì lấy url ảnh để cho tiếp vào Database
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        // Info User kiểu Dictionary để cho vào Database
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        
                        // Cho name + email + profileImageUrl vào Database
                        self.registerUserIntoDatabase(uid: userUId, values: values)
                    }
                })
            }
        })
    }
    
    func registerUserIntoDatabase(uid: String, values: [String: Any]) {
        // Lấy reference Database
        let ref = FIRDatabase.database().reference(fromURL: "https://craty-e784e.firebaseio.com/")
        
        // Set User reference users - uid
        let userRef = ref.child("users").child(uid)
        
        // Insert đống dictionary (values) vào database
        userRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            
            let user = User()
            // Set keys - values tương ứng với class User để lưu user trong máy
            user.setValuesForKeys(values)
            
            self.dismiss(animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker  = originalImage
        } else if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.imageView.image = selectedImage
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    // UITextField
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        return true
    }
    
    // Observer for keyboard
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func handleKeyboardWillShow(notification: Notification) {
        let keyboardFrame = ((notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = ((notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        registerToBottom.constant = keyboardFrame!.height + 40
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func handleKeyboardWillHide(notification: Notification) {
        let keyboardDuration = ((notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        registerToBottom.constant = 24
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
