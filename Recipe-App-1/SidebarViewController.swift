//
//  SidebarViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController {
    
    @IBOutlet weak var sidebarSearchField: NSSearchField!
    @IBOutlet weak var sidebarOutlineView: NSOutlineView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    @IBAction func deleteRecipeButtonActive(sender: AnyObject) {
    }

    @IBAction func addRecipeButtonActive(sender: AnyObject) {
    }
    
    @IBAction func sidebarSearchFieldActive(sender: AnyObject) {
    }
}
