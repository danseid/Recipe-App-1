//
//  SidebarViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {
    
    @IBOutlet weak var sidebarSearchField: NSSearchField!
    @IBOutlet weak var sidebarOutlineView: NSOutlineView!
    
    var recipes = [Category: [Recipe]]()
    var catList: [Category] {
        get{return Array(recipes.keys)}
    }
    var displayRecipe: Recipe?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.setupSampleRecipes()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func setupSampleRecipes() {
        let sampleRecipe1 = Recipe(title: "Salmon", rating: 4.0, ingredients: [Ingredient(name: "Salmon Fillets", quantity: 2.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [Category(name: "Fish", desc: "Fish dishes", icon: nil)], image: NSImage(named: "Salmon"))
        let sampleRecipe2 = Recipe(title: "Tuna", rating: 3.0, ingredients: [Ingredient(name: "Tuna Fillets", quantity: 2.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [Category(name: "Fish", desc: "Fish dishes", icon: nil)], image: NSImage(named: "Tuna"))
        let sampleRecipe3 = Recipe(title: "Paella", rating: 5.0, ingredients: [Ingredient(name: "Chicken Thighs", quantity: 4.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [Category(name: "Rice Dishes", desc: "Rice dishes", icon: nil)], image: NSImage(named: "Paella"))
        
        let sampleCategory1 = Category(name: "Sample Category 1", desc: "This is sample 1", icon: nil)
        let sampleCategory2 = Category(name: "Sample Category 2", desc: "This is sample 2", icon: nil)
        
        recipes = [sampleCategory1: [sampleRecipe1, sampleRecipe2, sampleRecipe3], sampleCategory2: [sampleRecipe2, sampleRecipe3]]
    }
    

    @IBAction func deleteRecipeButtonActive(sender: AnyObject) {
    }

    @IBAction func addRecipeButtonActive(sender: AnyObject) {
    }
    
    @IBAction func sidebarSearchFieldActive(sender: AnyObject) {
    }
    
    // Functions to implement NSOutlineView DataSource
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let it = item as? Category {  // If selected item is category,
            if let recipeList = self.recipes[it] as [Recipe]? {  // Unwrap its children recipes
                return recipeList[index]
            }
        }
        return (self.catList[index] as Category?)!  // If at root view, items will be categories
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let it = item as? Category {  // Only category items are expandable
            if self.numberOfRecipesInCategory(it) > 0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if let it = item as? Category {
            return self.numberOfRecipesInCategory(it)
        } else {
            return recipes.count
        }
    }
    
    func numberOfRecipesInCategory(category: Category) -> Int {
        if let recs = self.recipes[category] {
            return recs.count
        } else {
            return 0
        }
    }
    
    // Function to implement the NSOutlineView Delegate
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        switch item {  // Setup different TableViewCells depending on the type of item selected
        case let category as Category:
            let view = sidebarOutlineView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = category.name
            }
            if let icon = category.icon {
                view.imageView!.image = icon
            }
            return view
        case let recipe as Recipe:
            let view = sidebarOutlineView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = recipe.title
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
        var selectedIndex = notification.object?.selectedRow
        var object:AnyObject? = notification.object?.itemAtRow(selectedIndex!)
        
        if (object is Recipe){
            self.displayRecipe = (object as! Recipe)
            if let detailView = self.parentViewController?.childViewControllers[1] as? DetailViewController { // Send object details to Detail VC
                detailView.displayRecipe = self.displayRecipe
            }
        }
    }
    
    func reloadSelectedRecipeRow() {        //Refresh single row of the table view
        let indexSet = NSIndexSet(index: self.sidebarOutlineView.selectedRow)
        let columnSet = NSIndexSet(index: 0)
        self.sidebarOutlineView.reloadDataForRowIndexes(indexSet, columnIndexes: columnSet)
    }
}
