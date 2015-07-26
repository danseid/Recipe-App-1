//
//  SplitViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController, NSSplitViewDelegate {
    
    @IBOutlet weak var mainSplitView: NSSplitView!
    @IBOutlet weak var sidebarSubView: NSSplitViewItem!
    @IBOutlet weak var detailSubView: NSSplitViewItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.mainSplitView.setPosition(200, ofDividerAtIndex: 0)
    }
}
