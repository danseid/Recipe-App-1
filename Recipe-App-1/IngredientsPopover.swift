//
//  IngredientsPopover.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 16/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class IngredientsPopover: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    var ingredients: [AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.ingredients.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        if let ingredient = self.ingredients[row] as? Ingredient {
            if tableColumn!.identifier == "quantity" {
                cellView.textField!.doubleValue = ingredient.quantity!
            }
            else if tableColumn!.identifier == "unit" {
                cellView.textField!.stringValue = ingredient.unit!.rawValue
            }
            else if tableColumn!.identifier == "ingredient" {
                cellView.textField!.stringValue = ingredient.name
            }
            else {
                cellView.textField!.stringValue = ingredient.preparation!
            }
        }
        
        return cellView
    }
}
