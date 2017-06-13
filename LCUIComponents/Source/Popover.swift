//
//  Dialog.swift
//  PopupDialog
//
//  Created by Linh Chu on 16/5/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import Foundation
import UIKit

public protocol LCPopoverDelegate: class {
    associatedtype T
    func didSelectData(_ selectedData: LCTuple<T>)
}

public enum Options {
    case size(CGSize)
    case isAddingCancel(Bool)
}

//fileprivate protocol KeyValueArray
//{
//    associatedtype T
//    var dataList:[LCTuple<T>] { get set }
//}
//
//extension KeyValueArray
//{
//    var array:[(key: T, value:String)] { get {return []} set { } }
//}

public typealias LCTuple<T> = (key: T, value: String)

open class LCPopover<T>: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    // Public properties
//    open weak var delegate: LCPopoverDelegate?
    open var dataList = [LCTuple<T>]()
    open var size = CGSize(width: 250, height: 220)
    open var isAddingCancel = true
    
    // Private constants
    fileprivate let cellIdentifier = "Cell"
    
    // Private properties
    fileprivate var tableView: UITableView!
    fileprivate var displayValues = Array<String>()
    
    init(sender: UIView, title: String = "") {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        modalPresentationStyle = .popover
        preferredContentSize = size
        
        updatePosition(sender: sender)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Update position based on the associated view
    func updatePosition(sender: UIView) {
        if let popoverPC = popoverPresentationController {
            popoverPC.sourceView = sender
            popoverPC.sourceRect = sender.bounds
            popoverPC.permittedArrowDirections = .any
            popoverPC.delegate = self
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    fileprivate func addViews() {
        // Add navigation bar
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: preferredContentSize.width, height: 44))
        let navItem = UINavigationItem(title: self.title ?? "")
        
        let btnCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(btnCancelTapped))
        
        navItem.leftBarButtonItem = btnCancel
        navBar.setItems([navItem], animated: true)
        view.addSubview(navBar)
        
        // Add table view
        let barHeight: CGFloat = navBar.frame.size.height
        let tableWidth = preferredContentSize.width
        let tableHeight = preferredContentSize.height
        let tableFrame = CGRect(x: 0, y: barHeight, width: tableWidth, height: tableHeight - barHeight)
        
        tableView = UITableView(frame: tableFrame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorInset.left = 0
        view.addSubview(tableView)
    }
    
    @objc fileprivate func btnCancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = dataList[indexPath.row].value
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.didSelectData(dataList[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

//// MARK: -
//// MARK: - TableView Delegate Methods
//
//extension LCPopover: UITableViewDelegate, UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataList.count
//    }
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
//        
//        cell.textLabel?.text = dataList[indexPath.row].value
//        return cell
//    }
//    
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.didSelectData(dataList[indexPath.row])
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//
//// MARK: -
//// MARK: - PopoverPC Delegate Methods
//
//extension LCPopover: UIPopoverPresentationControllerDelegate {
//    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.none
//    }
//}

