//
//  DetailTabViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 26/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

//Contains the details views: DetailViewController for recipes, and the CategoryCollectionVC and CategoryTableVC for categories
class DetailTabViewController: NSTabViewController {
    
    @IBOutlet weak var recipeDetailTab: NSTabViewItem!
    @IBOutlet weak var categoryCollectionTab: NSTabViewItem!
    @IBOutlet weak var categoryDetailTab: NSTabViewItem!

    override func viewDidLoad() {
        super.viewDidLoad()
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
