//
//  ProductViewTableViewCell.swift
//  Crafty
//
//  Created by Nguyen Bach on 3/7/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import DOFavoriteButton
import Firebase
class ProductViewTableViewCell: UITableViewCell {
    @IBOutlet weak var btnLike: DOFavoriteButton!

    @IBOutlet weak var btnSmile: DOFavoriteButton!
    @IBOutlet weak var btnStar: DOFavoriteButton!
    @IBOutlet weak var btnHeart: DOFavoriteButton!
 //   @IBOutlet var heartBtn: DOFavoriteButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var smileLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var productID: String!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        btnHeart.imageColorOn = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        btnHeart.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        btnHeart.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        btnHeart.duration = 1.0
        btnHeart.addTarget(self, action: #selector(self.HeartTapped), for: .touchUpInside)
        
        btnLike.imageColorOn = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        btnLike.circleColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        btnLike.lineColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        btnLike.duration = 1.0
        btnLike.addTarget(self, action: #selector(self.LikeTapped), for: .touchUpInside)
        
        btnStar.addTarget(self, action: #selector(self.StarTapped), for: .touchUpInside)
        
        btnSmile.imageColorOn = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        btnSmile.circleColor = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        btnSmile.lineColor = UIColor(red: 45/255, green: 194/255, blue: 106/255, alpha: 1.0)
        btnSmile.duration = 1.0
        btnSmile.addTarget(self, action: #selector(SmileTapped), for: .touchUpInside)
        
    }
    func HeartTapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            self.heartLabel.text = "  "
            sender.deselect()
        } else {
           self.heartLabel.text = "1 ❤️"
            let ref = FIRDatabase.database().reference()
            let keyToPost = ref.child("products").childByAutoId().key
            ref.child("products").child(self.productID).observeSingleEvent(of: .value, with: { (snapshot) in
                if let product = snapshot.value as? [String: AnyObject]{
                    let updateHearts: [String:Any] = ["peopleWhoLike/\(keyToPost)": FIRAuth.auth()!.currentUser!.uid]
                    ref.child("products").child(self.productID).updateChildValues(updateHearts, withCompletionBlock: { (error, reff) in
                        if error == nil{
                            ref.child("products").child(self.productID).observeSingleEvent(of: .value, with: { (snap) in
                                if let properties = snap.value as? [String: AnyObject]{
                                    if let hearts = properties["peopleWhoLike"] as? [String : AnyObject]{
                                        let count = hearts.count
                                        if count == 1 {
                                            self.heartLabel.text = "\(count) ❤️"
                                        }else{
                                            self.heartLabel.text = "\(count) 💕"
                                        }
                                        let update = ["love":count]
                                        ref.child("products").child(self.productID).updateChildValues(update)
                                        
                                    }
                                }
                            })
                        }
                    })
                }
                
            })
            ref.removeAllObservers()
            sender.select()
        }
    }
    func LikeTapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            
            self.likeLabel.text = "  "
            sender.deselect()
        } else {
            self.likeLabel.text = "1 👍🏿"
            sender.select()
        }
    }
    func StarTapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            
            self.starLabel.text = "  "
            sender.deselect()
        } else {
            
            self.starLabel.text = "1 🌟"
            sender.select()
        }
    }
    func SmileTapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            
            self.smileLabel.text = "  "
            sender.deselect()
        } else {
            
            self.smileLabel.text = "1 🐷"
            sender.select()
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
