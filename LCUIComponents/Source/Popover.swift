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
    open var size: CGSize = CGSize(width: 250, height: 219)
    open var arrowDirection: UIPopoverArrowDirection = .any
    open var backgroundColor: UIColor = UIColor.clear
    open var borderWidth: CGFloat = 0
    open var cornerRadius: CGFloat = 20
    open var barHeight: CGFloat = 44
//    open var barColor: UIColor = UIColor(colorLiteralRed: 235/255, green: 235/255, blue: 241/255, alpha: 1)
    open var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 19)
    open var titleColor: UIColor = .black
    open var textFont: UIFont = UIFont.systemFont(ofSize: 17)
    open var textColor: UIColor = .black
    open var selectedData: LCTuple<T>?
    
    // Public closures
    open var didSelectDataHandler: ((_ selectedData: LCTuple<T>?) -> ())?
    
    // Private constants
    fileprivate let cellIdentifier = "Cell"
    
    // Private properties
    fileprivate var tableView: UITableView!
    
    init(for sender: UIView, title: String = "", didSelectDataHandler: ((_ selectedData: LCTuple<T>?) -> ())? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .popover
        setSourceView(sender)
        self.sender = sender
        self.title = title
        self.didSelectDataHandler = didSelectDataHandler
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        preferredContentSize = size
        setProperties()
        addViews()
    }
    
    override open func loadView() {
        super.loadView()
        
        
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    
    // MARK: - Private Methods
    
    // Set position for the popover coordinating with the sender
    fileprivate func setSourceView(_ sender: UIView) {
        guard let popoverPC = popoverPresentationController else { return }
        popoverPC.sourceView = sender
        popoverPC.sourceRect = sender.bounds
        popoverPC.delegate = self
     
    }
    
    // Set properties based on options passed to the initializer
    fileprivate func setProperties() {
        guard let popoverPC = popoverPresentationController else { return }
        popoverPC.permittedArrowDirections = arrowDirection
        popoverPC.backgroundColor = backgroundColor
        
        // Set corner radius
        
//        view.superview?.roundCorners([.allCorners], radius: cornerRadius)
        view.superview?.layer.cornerRadius = 0
        view.superview?.layer.borderWidth = 2
        view.superview?.layer.borderColor = backgroundColor.cgColor
        
//        view.superview?.backgroundColor = backgroundColor
        
//        view.superview?.layer.shadowColor = UIColor.clear.cgColor
//        view.superview?.layer.masksToBounds = true
        
//        view.superview?.clipsToBounds = true        
//        view.superview?.layer.masksToBounds = true
        
//        view.clipsToBounds = true
//        view.layer.masksToBounds = false
        
//        view.frame = (view.superview?.frame)!
//        view.bounds = (view.superview?.bounds)!
//        
//        preferredContentSize = view.frame.size
//        size = view.frame.size
//        view.layer.cornerRadius = cornerRadius
        
//        let s = CGSize(width: size.width + borderWidth, height: size.height + borderWidth)
//        view.frame = CGRect(origin: view.frame.origin, size: s)
//        view.layer.borderWidth = borderWidth
//        view.layer.borderColor = backgroundColor.cgColor
//        view.roundCorners([.bottomLeft, .bottomRight], radius: cornerRadius)
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        view.layer.shadowColor = UIColor.clear.cgColor

//        view.superview?.layer.cornerRadius = cornerRadius
        
//        popoverPC.popoverBackgroundViewClass = PopoverBackgroundView.self
//        preferredContentSize = CGSize(width: 248, height: 217)
//        view.superview?.frame = CGRect(x: 0, y: 0, width: 252, height: 221)
//        print(view)
//        print(view.frame)
//        print(view.superview)
//        print(view.superview?.frame)
        
    }
    
    // Add navigation bar and table view
    fileprivate func addViews() {
        
        addNavigationBar()
        addTableView()
    }
    
    fileprivate func addNavigationBar() {
        if barHeight == 0 { return }
        
        // Set title
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        titleLabel.textAlignment = .center
        titleLabel.text = self.title ?? ""
        titleLabel.sizeToFit()
        
        // Set navigation bar
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: size.width, height: barHeight))
        let navItem = UINavigationItem()
        navItem.titleView = titleLabel
        navBar.setItems([navItem], animated: false)
//        navBar.layer.cornerRadius = cornerRadius
//        navBar.barTintColor = backgroundColor
        view.addSubview(navBar)
    }
    
    fileprivate func addTableView() {
        // Set table view
        let tableFrame = CGRect(x: 0, y: barHeight, width: size.width, height: size.height - barHeight)
        tableView = UITableView(frame: tableFrame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorInset.left = 0
        tableView.separatorColor = backgroundColor
//        tableView.roundCorners([.bottomLeft, .bottomRight], radius: cornerRadius)                        
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

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

