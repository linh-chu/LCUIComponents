//
//  Dialog.swift
//  PopupDialog
//
//  Created by Linh Chu on 16/5/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import Foundation
import UIKit

public typealias LCTuple<T> = (key: T, value: String)

open class LCPopover<T>: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    // Public properties
    open var sender = UIView()
    open var dataList = [LCTuple<T>]()
    open var size = CGSize(width: 250, height: 219)
    open var arrowDirection: UIPopoverArrowDirection = .any
    open var cornerRadius: CGFloat = 20
    open var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 19)
    open var titleColor: UIColor = .black
    open var textFont: UIFont = UIFont.systemFont(ofSize: 17)
    open var textColor: UIColor = .black
    
    // Public closures
    open var didSelectDataHandler: ((_ selectedData: LCTuple<T>?) -> ())?
    
    // Private constants
    fileprivate let cellIdentifier = "Cell"
    
    // Private properties
    fileprivate var tableView: UITableView!
    fileprivate var displayValues = Array<String>()
    
    init(for sender: UIView, title: String = "", didSelectDataHandler: ((_ selectedData: LCTuple<T>?) -> ())? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .popover
        self.sender = sender
        self.title = title
        self.didSelectDataHandler = didSelectDataHandler
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = size
        setPosition(sender: sender)
        setViews()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setProperties()
    }
    
    // MARK: - Private Methods
    
    // Set position for the popover coordinating with the sender
    fileprivate func setPosition(sender: UIView) {
        if let popoverPC = popoverPresentationController {
            popoverPC.sourceView = sender
            popoverPC.sourceRect = sender.bounds
            popoverPC.permittedArrowDirections = arrowDirection
            popoverPC.delegate = self
        }
    }
    
    // Set properties based on options passed to the initializer
    fileprivate func setProperties() {
        // Set corner radius
        view.superview?.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
    
    // Add navigation bar and table view
    fileprivate func setViews() {
        // Set title
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        titleLabel.textAlignment = .center
        titleLabel.text = self.title ?? ""
        titleLabel.sizeToFit()
        
        // Set navigation bar
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: size.width, height: 44))
        let navItem = UINavigationItem()
        navItem.titleView = titleLabel
        navBar.setItems([navItem], animated: true)
        view.addSubview(navBar)
        
        // Set table view
        let barHeight: CGFloat = navBar.frame.size.height
        let tableFrame = CGRect(x: 0, y: barHeight, width: size.width, height: size.height - barHeight)
        tableView = UITableView(frame: tableFrame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorInset.left = 0
        view.addSubview(tableView)
    }
   
    // MARK: - TableView Delegate Methods
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = dataList[indexPath.row].value
        cell.textLabel?.font = textFont
        cell.textLabel?.textColor = textColor
        return cell
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        didSelectDataHandler?(dataList[indexPath.row])
    }
    
    // MARK: - PopoverPC Delegate Methods
    
    open func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}


