//
//  ProductViewController.swift
//  Crafty
//
//  Created by Nguyen Bach on 3/5/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    var product: Product!
    var headerView: ProductViewHeader1!
    var headerMaskLayer: CAShapeLayer!
    var tableHeaderHeight: CGFloat = 290.0
    var tableHeaderCutAway: CGFloat = 50.0
    var nf = NumberFormatter()
    var product333 = [Product]()
   
    struct StoryBoard{
        static let tableViewCellIdentifier = "cell"
        static let tableViewCellIdentifier1 = "cell1"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        headerView = tableview.tableHeaderView as! ProductViewHeader1
        headerView.imageBackgroundProduct.sd_setImage(with: URL(string: product.images[0]))
        tableview.tableHeaderView = nil
        tableview.addSubview(headerView)
        tableview.contentInset = UIEdgeInsetsMake(tableHeaderHeight, 0, 0, 0)
        tableview.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        tableview.estimatedRowHeight = 65.0
        tableview.rowHeight = UITableViewAutomaticDimension
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()
        
    }
       override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderView()
    }
    override func viewDidLayoutSubviews() {
        updateHeaderView()
    }
    func updateHeaderView() {
        let effectiveHeight = tableHeaderHeight - tableHeaderCutAway / 2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableview.bounds.width, height: tableHeaderHeight)
        if tableview.contentOffset.y < -effectiveHeight{
            headerRect.origin.y = tableview.contentOffset.y
            headerRect.size.height = -tableview.contentOffset.y + tableHeaderCutAway / 2
        }
        headerView.frame = headerRect
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - tableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ProductViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section
        }else{
            return 100
        }
    }
    private func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 366
    }
    
    private func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.tableViewCellIdentifier, for: indexPath) as! ProductViewTableViewCell
            cell.titleLabel.text = product.title
           
            cell.priceLabel.text = "$\(nf.string(from: product.price!))"
            cell.descriptionLabel.text = product.detail
            cell.heartLabel.text = "\(self.product.love!) ❤️"
            cell.productID = self.product.productID
            cell.sizeToFit()
            return cell
        }else{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: StoryBoard.tableViewCellIdentifier1, for: indexPath) as UITableViewCell
            return cell1
        }
        
    }
    
}
extension ProductViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}
