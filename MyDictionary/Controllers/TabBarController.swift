//
//  TabBarController.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/21/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import UIKit
import FloatingTabBarController

class TabBarController: FloatingTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        tabBar.tintColor = UIColor(white: 0.75, alpha: 1)
        
        viewControllers = (1...2).map { "Tab\($0)" }.map {
            let selected = UIImage(systemName: "magnifyingglass")!
            let normal = UIImage(named: "magnifyingglass")!
            let controller = storyboard!.instantiateViewController(withIdentifier: $0)
            controller.title = $0
            controller.view.backgroundColor = UIColor(named: $0)
            controller.floatingTabItem = FloatingTabItem(selectedImage: selected, normalImage: normal)
            return controller
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
