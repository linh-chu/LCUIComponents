//
//  Dialog.swift
//  PopupDialog
//
//  Created by Linh Chu on 16/5/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import Foundation
import UIKit

public enum Options {
    case isAddingCancel(Bool)
}

public typealias KeyValueTuple = (key: Int, value: String)

public protocol LCPopoverDelegate: class {
    func didSelectData(_ selectedData: KeyValueTuple)
}

open class LCPopover: UIViewController {
    
    let cellIdentifier = "Cell"
    
    // Public properties
    open weak var delegate: LCPopoverDelegate?
    open var arrayData = [KeyValueTuple]()
    
    fileprivate var tableView: UITableView!
    
    convenience init(for sender: UIView, _ size: CGSize = CGSize(width: 250, height: 230)) {
        self.init()
        modalPresentationStyle = .popover
        preferredContentSize = size
//        self.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        updatePosition(for: sender)
    }
    
    // Update position based on the associated view
    func updatePosition(for sender: UIView) {
        if let popoverPC = popoverPresentationController {
            popoverPC.sourceView = sender
            popoverPC.sourceRect = sender.bounds
            popoverPC.permittedArrowDirections = .any
            popoverPC.delegate = self
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        //self.parent?.title = title
//        self.navigationController.bar
        
//        self.title = "ABC"
        
        let navBar = navigationBar()
        view.addSubview(navBar)
        
        let barHeight: CGFloat = navBar.frame.size.height
        let tableWidth = preferredContentSize.width
        let tableHeight = preferredContentSize.height
        let tableFrame = CGRect(x: 0, y: barHeight, width: tableWidth, height: tableHeight - barHeight)
        
        tableView = UITableView(frame: tableFrame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    fileprivate func navigationBar() -> UINavigationBar {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: preferredContentSize.width, height: 44))
        let navItem = UINavigationItem(title: self.title ?? "")
        
        let btnCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(btnCancelTapped))
        
        navItem.leftBarButtonItem = btnCancel
        navBar.setItems([navItem], animated: true)
        
        return navBar
    }
    
    @objc fileprivate func btnCancelTapped() {
        dismiss(animated: false, completion: nil)
    }
    
    
}

// MARK: -
// MARK: - TableView Delegate Methods

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

// MARK: -
// MARK: - PopoverPC Delegate Methods

extension LCPopover: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

