//
//  PagingViewController.swift
//  PagingViewController
//
//  Created by Jimmy Hoang on 3/1/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import XLPagerTabStrip

class PagingViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = Color.strongYellow
        settings.style.buttonBarItemFont = UIFont(name: "Lato-Regular", size: 9)!
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.blue
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
   
        moveToViewController(at: 1)
        changeCurrentIndexProgressive = {
            (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = Color.darkPurple
            newCell?.label.textColor = Color.darkPurple
        }
        super.viewDidLoad()
        
    }
    
    override func awakeFromNib() {
        self.navigationController?.navigationBar.setup()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.changeTitleView(width: self.navigationController!.navigationBar.frame.size.width, height: self.navigationController!.navigationBar.frame.size.height)

    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let home1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home1")
        let home2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home2")
        let home3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home3")
        
        return [home1, home2, home3]
    }
}
