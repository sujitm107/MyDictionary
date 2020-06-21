//
//  CustomTabViewController.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/21/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import UIKit

class CustomTabViewController: UIViewController {
    
    var selectedIndex: Int = 0
    var previousIndex: Int = 0
    
    var viewControllers = [UIViewController]()
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var tabView:UIView!
    
    var footerHeight: CGFloat = 50
    
    static let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController")
    static let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WordListViewController")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTab()
        
        viewControllers.append(CustomTabViewController.firstVC)
        viewControllers.append(CustomTabViewController.secondVC)
        
        buttons[selectedIndex].isSelected = true
        tabChanged(sender: buttons[selectedIndex])

    }
    
    func setUpTab() -> Void {
        tabView.layer.shadowColor = UIColor.gray.cgColor
        tabView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        tabView.layer.shadowOpacity = 0.5
        //shadowpath?
        tabView.layer.shadowRadius = 4
        tabView.clipsToBounds = true
        tabView.layer.cornerRadius = 25
        tabView.layer.masksToBounds = false
    }
    
    @IBAction func tabChanged(sender: UIButton) {
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParent: nil)
        //What is the superview?
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        self.view.bringSubviewToFront(tabView)
        
        
        
    }
    
}