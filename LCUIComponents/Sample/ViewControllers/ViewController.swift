//
//  ViewController.swift
//  LCUIComponents
//
//  Created by Linh Chu on 16/5/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var lblSelectedData: UILabel!
    @IBOutlet weak var btnPopover: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPopover.setTitle("Select a spice", for: .normal)
    }
    
    @IBAction func btnPopoverTapped(_ sender: UIButton) {
        
        let lcVC = LCPopover<Int>(for: sender, title: "Spices") { [weak self] selectedData in
            // After data has been selected
            self?.lblSelectedData.text = selectedData?.value ?? ""
        }
        lcVC.dataList = [(key: 1, value:"Cinnamon"),
                         (key: 2, value:"Cloves"),
                         (key: 3, value:"Ginger"),
                         (key: 4, value:"Turmeric"),
                         (key: 5, value:"Tamarind")]
        lcVC.size = CGSize(width: 250, height: 219)
        lcVC.arrowDirection = .up
//        lcVC.borderColor = .orange
//        lcVC.borderWidth = 2
        lcVC.cornerRadius = 0
        lcVC.barHeight = 44
        lcVC.titleFont = UIFont.boldSystemFont(ofSize: 19)
        lcVC.titleColor = .orange
        lcVC.textFont = UIFont(name: "HelveticaNeue-MediumItalic", size: 17) ?? UIFont.systemFont(ofSize: 17)
        lcVC.textColor = .black
        
        present(lcVC, animated: true, completion: nil)
    }
}
