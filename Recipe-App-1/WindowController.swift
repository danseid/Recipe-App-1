//
//  WindowController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 09/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
    }
    
    var splitViewController: SplitViewController {
        get { return self.window!.contentViewController! as! SplitViewController }
    }

    @IBAction func toolbarSidebarButtonActive(sender: AnyObject) {  // Connects toolbar button to collapse the sidebar VC
        if let sidebarState = self.splitViewController.sidebarSubView?.collapsed {
            NSAnimationContext.runAnimationGroup({ context in  // Animates the collapse/uncollapse
                self.splitViewController.sidebarSubView.animator().collapsed = !sidebarState
            }, completionHandler: nil)
        }
    }
}
