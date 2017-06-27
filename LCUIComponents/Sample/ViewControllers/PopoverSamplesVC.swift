
import UIKit

class PopoverSamplesVC: UIViewController {
    
    // Create a data source
    let spiceList: [LCTuple<Int>] = [(key: 1, value:"Cinnamon"),
                                     (key: 2, value:"Cloves"),
                                     (key: 3, value:"Ginger"),
                                     (key: 4, value:"Turmeric"),
                                     (key: 5, value:"Tamarind")]
    
    @IBAction func btnPopoverTapped(_ sender: UIButton) {
        setupCustomPopover(for: sender)
    }
    
    func setupCustomPopover(for sender: UIView) {
        // Init a popover with a callback closure after selecting data
        let popover = LCPopover<Int>(for: sender, title: "Spices") { tuple in
            // Use of the selected tuple
            guard let value = tuple?.value else { return }
            print(value)
        }
        // Assign data to the dataList
        popover.dataList = spiceList
        
        // Set popover properties
        popover.size = CGSize(width: 250, height: 219)
        popover.arrowDirection = .down
        popover.backgroundColor = .orange
        popover.borderColor = .orange
        popover.borderWidth = 2
        popover.barHeight = 44
        popover.titleFont = UIFont.boldSystemFont(ofSize: 19)
        popover.titleColor = .orange
        popover.textFont = UIFont(name: "HelveticaNeue-MediumItalic", size: 17) ?? UIFont.systemFont(ofSize: 17)
        popover.textColor = .black
        
        // Present the popover
        present(popover, animated: true, completion: nil)
    }
}
