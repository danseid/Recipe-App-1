//
//  DetailViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {

    @IBOutlet weak var recipeImageWell: NSImageView!
    @IBOutlet weak var recipeTextField: NSTextField!
    @IBOutlet weak var recipeIngredientsTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func recipeImageWellActive(sender: AnyObject) {
    }
}
