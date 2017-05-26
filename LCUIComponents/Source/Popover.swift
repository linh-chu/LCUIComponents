//
//  Dialog.swift
//  PopupDialog
//
//  Created by Linh Chu on 16/5/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import Foundation
import UIKit

typealias KeyValueTuple = (key: Int, value: String)

protocol PopupDialogDelegate: class {
    func didSelectData(_ selectedData: KeyValueTuple)
}

open class PopupDialog: UIViewController {
    
    let cellIdentifier = "Cell"
    
    weak var delegate: BasePopoverDelegate?
    var tableView: UITableView!
    var arrayData = [KeyValueTuple]()
    
    convenience init(for sender: UIView, _ size: CGSize = CGSize(width: 250, height: 230)) {
        self.init()
        modalPresentationStyle = .popover
        preferredContentSize = size
        updatePosition(for: sender)
    }
    
    // Update position based on the associated view
    func updatePosition(for sender: UIView) {
        if let popoverPC = popoverPresentationController {
            popoverPC.sourceView = sender
            popoverPC.sourceRect = sender.bounds
            popoverPC.permittedArrowDirections = .any
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}
