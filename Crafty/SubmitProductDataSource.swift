//
//  SubmitProductDataSource.swift
//  Crafty
//
//  Created by Jimmy Hoang on 2/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class SubmitProductDataSource: NSObject, UITableViewDataSource {
    
    var productCell = ProductImageCell()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "DETAILS"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            var cell = UITableViewCell()
            
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
                break
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
                break
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath)
                break
            case 3:
                cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell", for: indexPath)
                break
            default:
                break
            }
            return cell
        
    }
}
