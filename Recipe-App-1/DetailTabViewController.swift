//
//  DetailTabViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 26/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class DetailTabViewController: NSTabViewController {
    @IBOutlet weak var recipeDetailTab: NSTabViewItem!
    @IBOutlet weak var categoryCollectionTab: NSTabViewItem!
    @IBOutlet weak var categoryDetailTab: NSTabViewItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func displayRecipeDetail() {
        self.selectedTabViewItemIndex = 0
    }
    
    func displayCategoryCollection() {
        self.selectedTabViewItemIndex = 1
    }
    
    func displayCategoryDetail() {
        if let categoryDetailView = self.categoryDetailTab.viewController as? CategoryTableViewController {
            categoryDetailView.categoryDetailTableViewController.reloadData()
        }
        self.selectedTabViewItemIndex = 2
    }
}
