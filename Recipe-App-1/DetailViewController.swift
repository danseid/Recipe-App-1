//
//  DetailViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var recipeImageWell: NSImageView!
    @IBOutlet weak var recipeTextField: NSTextField!
    @IBOutlet weak var recipeIngredientsOutlineView: NSOutlineView!
    @IBOutlet weak var dropImageLabel: NSTextField!
    
    var recipe = Recipe()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var displayRecipe: Recipe? {
        didSet {
            // Update the view.
            self.configureDisplayRecipe()
        }
    }
    
    func configureDisplayRecipe() {
        // Update the user interface for the detail item.
        if let recipe: Recipe = self.displayRecipe {
            self.recipe = recipe
            self.recipeTextField.enabled = true
            self.recipeTextField.stringValue = recipe.name
            self.recipeImageWell.image = recipe.image
            if self.recipeImageWell.image != nil {
                self.dropImageLabel.stringValue = ""
            }
            self.recipeIngredientsOutlineView.reloadData()
        }
    }
    
    @IBAction func recipeImageWellActive(sender: AnyObject) {
        self.displayRecipe!.image = self.recipeImageWell.image
        self.configureDisplayRecipe()
        self.updateSidebarViewController()
    }
    
    @IBAction func recipeTextFieldDidFinishEditing(sender: AnyObject) {
        self.displayRecipe!.name = self.recipeTextField.stringValue
        self.updateSidebarViewController()
    }
    
    func updateSidebarViewController() {
        if let sidebarView = self.parentViewController!.childViewControllers[0] as? SidebarViewController {
            sidebarView.reloadSelectedRecipeRow()
        }
    }

    // Functions to implement NSOutlineView DataSource
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return self.recipe.ingredients[index]
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return false
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        return self.recipe.ingredients.count
    }
    
    // Function to implement the NSOutlineView Delegate
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        switch item {  // Setup different TableViewCells depending on the type of item selected
        case let ingredient as Ingredient:
            let view = recipeIngredientsOutlineView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = ingredient.tableDisplayString()
            }
            return view
        case let recipe as Recipe:
            let view = recipeIngredientsOutlineView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = recipe.name
            }
            if let image = recipe.image as NSImage? {
                view.imageView!.image = image
            }
            return view
        default:
            return nil
        }
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification){  // Retrieve selected object from OutlineView
//        var selectedIndex = notification.object?.selectedRow
//        var object:AnyObject? = notification.object?.itemAtRow(selectedIndex!)

    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ingredientPopover" {
            let destination: IngredientsPopover = segue.destinationController as! IngredientsPopover
        }
    }
}
