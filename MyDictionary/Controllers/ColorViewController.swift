//
//  ColorViewController.swift
//  MyDictionary
//
//  Created by Sujit Molleti on 6/25/20.
//  Copyright © 2020 Sujit Molleti. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    static var theme = UIColor(displayP3Red: 255/255, green: 90/255, blue: 95/255, alpha: 1.0)
    
    var colorChangerDelegate: ColorChanger?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func colorButtonTapped(_ sender: UIButton!) {
        
        let color: UIColor = sender.backgroundColor!
        colorChangerDelegate?.changeColors(color: color)
        
    }
    
}
