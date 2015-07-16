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
    @IBOutlet weak var recipeIngredientsTableView: NSTableView!
    @IBOutlet weak var dropImageLabel: NSTextField!
        
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
            self.recipeTextField.enabled = true
            self.recipeTextField.stringValue = recipe.name
            self.recipeImageWell.image = recipe.image
            if self.recipeImageWell.image != nil {
                self.dropImageLabel.stringValue = ""
            }
            self.recipeIngredientsTableView.reloadData()
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
    
    @IBAction func recipeIngredientFinishEditing(sender: AnyObject) {
    }
    
    func updateSidebarViewController() {
        if let sidebarView = self.parentViewController!.childViewControllers[0] as? SidebarViewController {
            sidebarView.reloadSelectedRecipeRow()
        }
    }
    
    // TableView DataSource implementation
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        if let recipe = self.displayRecipe as Recipe? {
            if let ingredients = recipe.ingredients as [Ingredient]? {
                return ingredients.count + 1
            }
        }
        return 1
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = recipeIngredientsTableView.makeViewWithIdentifier("Ingredient Column", owner: self) as! NSTableCellView
        if let recipe = self.displayRecipe as Recipe?{
            if let ingredients = recipe.ingredients as [Ingredient]? {
                if row < ingredients.count {
                    view.textField!.stringValue = ingredients[row].tableDisplayString()
                } else {
                    view.textField!.stringValue = "Add ingredient"
                }
            } else {
                view.textField!.stringValue = "Add ingredient"
            }
        }
        return view
    }
    
    // TableView Delegate implementation
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ingredientPopover" {
            let destination: IngredientsPopover = segue.destinationController as! IngredientsPopover
        }
    }
}
