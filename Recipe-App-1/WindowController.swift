//
//  WindowController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 09/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    @IBOutlet weak var categoryViewSelector: NSSegmentedControl!
    
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
    
    @IBAction func toolbarCategoryViewButtonActive(sender: AnyObject) {
        if let detailTabView = self.splitViewController.detailSubView.viewController as? DetailTabViewController {
            if let sidebarView = self.splitViewController.sidebarSubView.viewController as? SidebarViewController {
                if detailTabView.selectedTabViewItemIndex != 0 {
                    detailTabView.selectedTabViewItemIndex = self.categoryViewSelector.selectedSegment + 1
                }
                sidebarView.segmentedControlState = self.categoryViewSelector.selectedSegment
            }
        }
    }
}
