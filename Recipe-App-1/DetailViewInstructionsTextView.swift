//
//  DetailViewInstructionsTextView.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 03/11/2015.
//  Copyright © 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class DetailViewInstructionsTextView: NSTextView {
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }

    override func mouseDown(theEvent: NSEvent) {
        //self.superview?.mouseDown(theEvent)
        super.mouseDown(theEvent)
    }
    
}
