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
    @IBOutlet weak var sidebarDeleteButton: NSButton!

    var displayRecipe: Recipe?
    
    var recipes = [Recipe]()
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.setupNewRecipesCategory()
        self.setupSampleRecipes()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func setupSampleRecipes() {
        let sampleRecipe1 = Recipe(name: "Salmon", rating: 4.0, ingredients: [IngredientGroup(name: "Group 1"): [Ingredient(name: "Salmon Fillets", quantity: 2.0, unit: Ingredient.unitEnum.none, preparation: "", notes: "")], IngredientGroup(name: "Group 2"): [Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")]], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [], image: NSImage(named: "Salmon"))
        let sampleRecipe2 = Recipe(name: "Tuna", rating: 3.0, ingredients: [IngredientGroup(name: "noGroup"): [Ingredient(name: "Tuna Fillets", quantity: 2.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")]], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [], image: NSImage(named: "Tuna"))
        let sampleRecipe3 = Recipe(name: "Paella", rating: 5.0, ingredients: [IngredientGroup(name: "noGroup"): [Ingredient(name: "Chicken Thighs", quantity: 4.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")]], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [], image: NSImage(named: "Paella"))
        
        let sampleCategory1 = Category(name: "Sample Category 1", desc: "This is sample 1", recipes: [sampleRecipe1, sampleRecipe2, sampleRecipe3], icon: nil)
        let sampleCategory2 = Category(name: "Sample Category 2", desc: "This is sample 2", recipes: [sampleRecipe2, sampleRecipe3], icon: nil)
        
        sampleRecipe1.addCategory(sampleCategory1)
        sampleRecipe2.addCategory(sampleCategory1)
        sampleRecipe2.addCategory(sampleCategory2)
        sampleRecipe3.addCategory(sampleCategory1)
        sampleRecipe3.addCategory(sampleCategory2)

        self.recipes.append(sampleRecipe1)
        self.recipes.append(sampleRecipe2)
        self.recipes.append(sampleRecipe3)
        self.categories.append(sampleCategory1)
        self.categories.append(sampleCategory2)
    }
    
    func setupNewRecipesCategory() {  // Setup New Recipes category, the default initial category for all recipes
        let newRecipesCategory = Category(name: "New Recipes", desc: "The most recently added recipes", recipes: [], icon: nil)
        self.categories.append(newRecipesCategory)
    }

    @IBAction func deleteRecipeButtonActive(sender: AnyObject) {
        let selectedItem: AnyObject? = self.sidebarOutlineView.itemAtRow(self.sidebarOutlineView.selectedRow)
        let selectedItemParent: AnyObject? = self.sidebarOutlineView.parentForItem(selectedItem)
        switch selectedItem {
        case let recipe as Recipe:
            println(recipe.name)
        case let category as Category:
            println(category.name)
        default:
            println("Invalid item")
        }
    }

    @IBAction func addRecipeButtonActive(sender: AnyObject) {  // Implement 'Add recipe' Button
        let newRecipesCategory = self.categories[0]  // All new recipes added to New Recipes category by default
        let newRecipe = Recipe(name: "New Recipe", rating: nil, ingredients: [:], instructions: [], categories: [newRecipesCategory], image: nil)
        self.recipes.append(newRecipe)
        newRecipesCategory.addRecipe(newRecipe)
        
        self.sidebarOutlineView.reloadItem(newRecipesCategory)  // Reload OutlineView
        self.sidebarOutlineView.expandItem(newRecipesCategory)  // Expand New Recipes category
        
        let newRowIndex = newRecipesCategory.recipes.count
        self.sidebarOutlineView.selectRowIndexes(NSIndexSet(index: newRowIndex), byExtendingSelection: false) // Select to display in DetailView
        self.sidebarOutlineView.scrollRowToVisible(newRowIndex)  // Scroll OutlineView to display the correct row
        
        if let detailView = self.parentViewController!.childViewControllers[1] as? DetailViewController {
            detailView.recipeTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func sidebarSearchFieldActive(sender: AnyObject) {
    }
    
    // Functions to implement NSOutlineView DataSource
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let it = item as? Category {  // If selected item is category,
            if let recipes = it.recipes as [Recipe]? {
                return recipes[index]
            }
        }
        return self.categories[index] as Category  // If at root view, items will be categories
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
            return self.categories.count
        }
    }
    
    func numberOfRecipesInCategory(category: Category) -> Int {
        if let recipes = category.recipes as [Recipe]? {
            return recipes.count
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
        var selectedIndex = notification.object?.selectedRow
        var object:AnyObject? = notification.object?.itemAtRow(selectedIndex!)
        
        if (object is Recipe){
            self.displayRecipe = (object as! Recipe)
            if let detailView = self.parentViewController?.childViewControllers[1] as? DetailViewController { // Send object details to Detail VC
                detailView.displayRecipe = self.displayRecipe
            }
        }
        
        if object != nil {
            self.sidebarDeleteButton.enabled = true  // Enable delete button now that item is selected
        } else {
            self.sidebarDeleteButton.enabled = false
        }
    }
    
    func reloadSelectedRecipeRow() {        //Refresh single row of the table view
        let indexSet = NSIndexSet(index: self.sidebarOutlineView.selectedRow)
        let columnSet = NSIndexSet(index: 0)
        self.sidebarOutlineView.reloadDataForRowIndexes(indexSet, columnIndexes: columnSet)
    }
}
