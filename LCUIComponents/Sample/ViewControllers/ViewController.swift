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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnContactTapped(_ sender: UIButton) {

        
        let lcVC = LCPopover(for: sender)
        lcVC.delegate = self
        lcVC.title = "Popover"
        lcVC.arrayData = [(key: 0, value:"a"), (key: 1, value:"b")]
        //lcVC.popoverPresentationController?.delegate = self
        
        present(lcVC, animated: false, completion: nil)
    }
}

extension ViewController: LCPopoverDelegate {
    func didSelectData(_ selectedData: KeyValueTuple) {
        print(selectedData.value)
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



