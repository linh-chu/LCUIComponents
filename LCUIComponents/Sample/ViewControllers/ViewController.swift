//
//  ViewController.swift
//  LCUIComponents
//
//  Created by Linh Chu on 16/5/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import UIKit
import Foundation

class A {
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var btnPopover: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPopover.setTitle("Select a spice", for: .normal)
    }
    
    @IBAction func btnPopoverTapped(_ sender: UIButton) {
//        var controller: Controller? = Controller()
//        controller!.fetchData()
//        controller = nil
//        let a = A()
//        let array = [(key: a, value:"Cinnamon"),
//                     (key: a, value:"Cloves"),
//                     (key: a, value:"Ginger"),
//                     (key: a, value:"Turmeric"),
//                     (key: a, value:"Tamarind")]
        
//        let lcVC = LCPopover<Int>(sender: sender)
//        lcVC.dataList = [(key: 1, value:"Cinnamon"),
//                         (key: 2, value:"Cloves"),
//                         (key: 3, value:"Ginger"),
//                         (key: 4, value:"Turmeric"),
//                         (key: 5, value:"Tamarind")]
//        
//        present(lcVC, animated: true, completion: nil)
    }
}

extension ViewController: LCPopoverDelegate {
    func didSelectData(_ selectedData: LCTuple<Any>) {
        print(selectedData.value)
        print(selectedData.key)
    }
}

extension ViewController: UITextViewDelegate, UITextFieldDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
