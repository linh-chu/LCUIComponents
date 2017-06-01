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

protocol LCPopoverDelegate: class {
    func didSelectData(_ selectedData: KeyValueTuple)
}

open class LCPopover: UIViewController {
    
    let cellIdentifier = "Cell"
    
    weak var delegate: LCPopoverDelegate?
    var tableView: UITableView!
    var arrayData = [KeyValueTuple]()
    
    convenience init(for sender: UIView, _ size: CGSize = CGSize(width: 250, height: 230)) {
        self.init()
        modalPresentationStyle = .popover
        preferredContentSize = size        
        self.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
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
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight = UIApplication.shared.statusBarFrame.size.height
        let tableWidth = preferredContentSize.width
        let tableHeight = preferredContentSize.height
        let tableFrame = CGRect(x: 0, y: barHeight, width: tableWidth, height: tableHeight - barHeight)
        tableView = UITableView(frame: tableFrame, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
    }
}

extension LCPopover: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!

        cell.textLabel?.text = arrayData[indexPath.row].value
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectData(arrayData[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

