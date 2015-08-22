//
//  CategoryTableViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 24/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class CategoryTableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var categoryDetailTableViewController: NSTableView!
    var displayCategory: Category = Category()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.categoryDetailTableViewController.rowHeight = 60  //Figure out some way to make this automatic
        self.categoryDetailTableViewController.doubleAction = "doubleClickTableViewSelection"
    }
    
    override func viewDidAppear() {
        self.categoryDetailTableViewController.reloadData()
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.displayCategory.recipes.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) ->NSView? {
        var cellView: CategoryTableViewCell = tableView.makeViewWithIdentifier("recipeCell", owner: self) as! CategoryTableViewCell
        
        cellView.recipeTitleField.stringValue = self.displayCategory.recipes[row].name
        cellView.recipeCategoriesField.stringValue = self.displayCategory.name
        cellView.tableViewImage.image = self.displayCategory.recipes[row].image
        return cellView
    }
    
//    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
//        return self.displayCategory.recipes[row] as Recipe
//    }
    
    func doubleClickTableViewSelection() {
        var selectedIndex = self.categoryDetailTableViewController.selectedRow
        let detailTabView = self.parentViewController as! DetailTabViewController
        
        if let recipeDetailView = detailTabView.recipeDetailTab.viewController as? DetailViewController {
            //recipeDetailView.displayRecipe = (object as! Recipe)
            recipeDetailView.displayRecipe = self.displayCategory.recipes[selectedIndex] as Recipe
        }
        detailTabView.displayRecipeDetail()
    }
    
//    func tableViewSelectionDidChange(notification: NSNotification) {
//        var selectedIndex = notification.object?.selectedRow
////        println(selectedIndex)
////        var object:AnyObject? = notification.object?.itemAtRow(selectedIndex!)
////        println(object)
//        let detailTabView = self.parentViewController as! DetailTabViewController
//        
//        if let recipeDetailView = detailTabView.recipeDetailTab.viewController as? DetailViewController {
//            //recipeDetailView.displayRecipe = (object as! Recipe)
//            recipeDetailView.displayRecipe = self.displayCategory.recipes[selectedIndex!] as Recipe
//        }
//        detailTabView.displayRecipeDetail()
//    }

    
}
