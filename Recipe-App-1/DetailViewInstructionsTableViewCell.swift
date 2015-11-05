//
//  DetailViewInstructionsTableViewCell.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 14/10/2015.
//  Copyright © 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class DetailViewInstructionsTableViewCell: NSTableCellView {
    
    @IBOutlet weak var recipeInstructionTextView: NSScrollView!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
