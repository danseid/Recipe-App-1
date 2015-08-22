//
//  CategoryTableViewCell.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 19/08/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class CategoryTableViewCell: NSTableCellView {

    @IBOutlet weak var tableViewImage: NSImageView!
    @IBOutlet weak var recipeTitleField: NSTextField!
    @IBOutlet weak var recipeCategoriesField: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
