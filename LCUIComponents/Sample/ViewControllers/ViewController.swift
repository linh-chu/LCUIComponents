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
    @IBOutlet weak var tfPopover: UITextField!
    
    var popover: LCPopover<Int>!
    let titleSpice = "Spices"
    let titlePokemon = "Pokemons"
    let spiceList = [(key: 1, value:"Cinnamon"),
                         (key: 2, value:"Cloves"),
                         (key: 3, value:"Ginger"),
                         (key: 4, value:"Turmeric"),
                         (key: 5, value:"Tamarind")]
    let pokemonList = [(key: 1, value:"Pikachu"),
                          (key: 2, value:"Celebi"),
                          (key: 3, value:"Eevee"),
                          (key: 4, value:"Charmander"),
                          (key: 5, value:"Rowlet")]
    var filteredPokemons = [LCTuple<Int>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPopover.setTitle("Select a spice", for: .normal)        
    }
    
    @IBAction func btnPopoverTapped(_ sender: UIButton) {
        setupPopover(for: sender, title: titleSpice)
    }
    
    @IBAction func tfPopoverEditingChanged(_ sender: UITextField) {
        if let text = tfPopover.text {
            // Update the list of pokemons based on the input
            filteredPokemons = pokemonList.filter({ $0.value.contains(text) })
        }
        setupPopover(for: sender, title: titlePokemon)
    }
    
    func setupPopover(for sender: UIView, title: String) {
        if popover == nil {
            // Init a popover for the 1st time
            popover = LCPopover<Int>(for: sender, title: title) { [unowned self] selectedData in
                
                guard let value = selectedData?.value else { return }
                // After data has been selected
                if title == self.titleSpice {
                    self.lblSelectedData.text = value
                } else {
                    self.tfPopover.text = value
                }
            }
            
            // Set popover properties
            popover.size = CGSize(width: 250, height: 219)
            popover.arrowDirection = .down
            popover.backgroundColor = .blue
            popover.borderColor = .blue
            popover.borderWidth = 1
            popover.barHeight = 44
            popover.titleFont = UIFont.boldSystemFont(ofSize: 19)
            popover.titleColor = .blue
            popover.textFont = UIFont(name: "HelveticaNeue-MediumItalic", size: 17) ?? UIFont.systemFont(ofSize: 17)
            popover.textColor = .black
        } else {
            // Only update source, not creating a new popover
            popover.setSourceView(sender)
        }
        
        // Reset the data list and reload data if needed
        if title == self.titleSpice {
            popover.dataList = spiceList
        } else {
            popover.dataList = filteredPokemons
        }
        popover.reloadData()
        
        // Ignore if the popover is currently being presented
        if self.presentedViewController != popover {
            present(popover, animated: true, completion: nil)
        }
    }
}
