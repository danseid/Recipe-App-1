//
//  WindowController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 09/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBOutlet weak var categoryViewSelector: NSSegmentedControl!  // Outlet for toolbar segment control to switch Category view type
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    //Retrieve the in-use instance of SplitViewController to interact with splitviews and lower controllers
    var splitViewController: SplitViewController {
        get { return self.window!.contentViewController! as! SplitViewController }
    }

    @IBAction func toolbarSidebarButtonActive(sender: AnyObject) {  //Connects toolbar button to collapse the SidebarVC
        if let sidebarState = self.splitViewController.sidebarSubView?.collapsed {
            
            NSAnimationContext.runAnimationGroup(
                { context in self.splitViewController.sidebarSubView.animator().collapsed = !sidebarState }, //Simply switch the state
                completionHandler: nil)
            
        }
    }
    
    //Fires on activity in the toolbar segment control to switch
    @IBAction func toolbarCategoryViewButtonActive(sender: AnyObject) {
        if let detailTabView = self.splitViewController.detailSubView.viewController as? DetailTabViewController {
            if let sidebarView = self.splitViewController.sidebarSubView.viewController as? SidebarViewController {
                if detailTabView.selectedTabViewItemIndex != 0 {  //Do not change the current view if it is the DetailViewController
                    detailTabView.selectedTabViewItemIndex = self.categoryViewSelector.selectedSegment + 1  //Segment 0 -> CollectionView, segment 1 -> TableView
                }
                sidebarView.segmentedControlState = self.categoryViewSelector.selectedSegment  //Always keep track of which option is selected in the segment control
            }
        }
    }
}
