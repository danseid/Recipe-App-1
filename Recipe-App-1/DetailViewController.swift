//
//  DetailViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate, NSTableViewDataSource, NSTableViewDelegate, NSSplitViewDelegate {

    @IBOutlet weak var recipeImageWell: NSImageView!
    @IBOutlet weak var recipeTextField: NSTextField!
    @IBOutlet weak var recipeIngredientsOutlineView: NSOutlineView!
    @IBOutlet weak var dropImageLabel: NSTextField!
    @IBOutlet weak var recipeDetailSplitView: NSSplitView!
    @IBOutlet weak var recipeInstructionsTableView: NSTableView!
    
    var recipe = Recipe()
    var editedRecipeIngredients: [AnyObject]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.recipeInstructionsTableView.doubleAction = "doubleClickTableViewSelection"
    }
    
    override func viewDidAppear() {
        self.recipeDetailSplitView.setPosition(200, ofDividerAtIndex: 0)
    }

    override func viewDidLayout() {
        self.recipeInstructionsTableView.reloadData()  // Allows for row heights to be updated when the tableview width is changed
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
            self.recipeInstructionsTableView.reloadData()
        }
    }
    
    @IBAction func recipeImageWellActive(sender: AnyObject) {
        let image: NSImage = self.recipeImageWell.image!
        self.displayRecipe!.image = image //self.recipeImageWell.image
        self.configureDisplayRecipe()
        self.updateSidebarViewController()
    }
    
    @IBAction func recipeTextFieldDidFinishEditing(sender: AnyObject) {
        self.displayRecipe!.name = self.recipeTextField.stringValue
        self.updateSidebarViewController()
    }
    
    func updateSidebarViewController() {
        if let sidebarView = self.parentViewController?.parentViewController?.childViewControllers[0] as? SidebarViewController {
            sidebarView.reloadSelectedRecipeRow()
        }
    }

    // Functions to implement NSOutlineView DataSource
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        if let it = item as? IngredientGroup {
            if let ingredients = it.ingredients as [Ingredient]? {
                return ingredients[index]
            }
        }
        return self.recipe.ingredients[index]
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        if let it = item as? IngredientGroup {
            if it.ingredients.count > 0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        if let it = item as? IngredientGroup {
            return it.ingredients.count
        }
        return self.recipe.ingredients.count
    }
    
//    func expandOutlineViewItems() {
//        
//    }
    
//    func outlineView(outlineView: NSOutlineView, shouldExpandItem item: AnyObject) -> Bool {
//        if let it = item as? IngredientGroup {
//            return it.isExpanded
//        }
//        return false
//    }
    
    func outlineViewItemDidExpand(notification: NSNotification) {
        if let item = notification.object as? IngredientGroup {
            item.isExpanded = true
        }
    }
    
    func outlineViewItemDidCollapse(notification: NSNotification) {
        if let item = notification.object as? IngredientGroup {
            item.isExpanded = false
        }
    }

    // Function to implement the NSOutlineView Delegate
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        switch item {  // Setup different TableViewCells depending on the type of item selected
        case let ingredient as Ingredient:
            let view = self.recipeIngredientsOutlineView.makeViewWithIdentifier("IngredientCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = ingredient.tableDisplayString()
            }
            return view
        case let group as IngredientGroup:
            let view = self.recipeIngredientsOutlineView.makeViewWithIdentifier("GroupCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = group.name
            }
            return view
        default:
            return nil
        }
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification){  // Retrieve selected object from OutlineView
        let selectedIndex = notification.object?.selectedRow
        let object:AnyObject? = notification.object?.itemAtRow(selectedIndex!)
        
        if object is Ingredient || object is IngredientGroup {
            self.performSegueWithIdentifier("ingredientsPopover", sender: self)
        }

    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ingredientsPopover" {
            if let destination = segue.destinationController as? IngredientsPopover {
                self.editedRecipeIngredients = self.recipe.copyIngredients()
                destination.ingredients = self.editedRecipeIngredients
                destination.parentVC = self
            }
        }
    }
    
    func returnFromIngredientsPopover(status: Bool) {
        if !status {
            self.recipe.ingredients = self.editedRecipeIngredients
            self.recipeIngredientsOutlineView.reloadData()
        }
    }
    
    // Functions to implement the NSTableView DataSource/Delegate
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.recipe.instructions.count + 1
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if row < self.recipe.instructions.count {
            if tableColumn?.identifier == "InstructionColumn" {
                let view = self.recipeInstructionsTableView.makeViewWithIdentifier("InstructionCell", owner: self) as! DetailViewInstructionsTableViewCell
                if let textView = view.recipeInstructionTextView.documentView as? NSTextView {
                    textView.string = self.recipe.instructions[row].text
                }
                return view
            }
        } else {
            let view = self.recipeInstructionsTableView.makeViewWithIdentifier("AddInstructionCell", owner: self) as! NSTableCellView
            if let textField = view.textField {
                textField.stringValue = "Add instruction"
            }
            return view
        }
        return nil
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if row < self.recipe.instructions.count {
            let prototypeView: NSTextView = NSTextView(frame: NSRect(x: 0, y: 0, width: self.recipeInstructionsTableView.tableColumns[0].width, height: 17))
            prototypeView.string = self.recipe.instructions[row].text
            prototypeView.horizontallyResizable = false
            prototypeView.sizeToFit()
            return prototypeView.frame.height
        }
        return 17
    }

    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedIndex = notification.object?.selectedRow
        if selectedIndex == self.recipe.instructions.count {
            let newInstruction: Instruction = Instruction(text: "New instruction", step: self.recipe.instructions.count + 1)
            self.recipe.instructions.append(newInstruction)
            self.recipeInstructionsTableView.beginUpdates()
            self.recipeInstructionsTableView.insertRowsAtIndexes(NSIndexSet(index: selectedIndex!), withAnimation: NSTableViewAnimationOptions.SlideDown)
            self.recipeInstructionsTableView.endUpdates()

        }
    }
    
//    func doubleClickTableViewSelection() {
//        let selectedIndex = self.recipeInstructionsTableView.selectedRow
//        let selectedInstruction = self.recipe.instructions[selectedIndex]
//        if selectedInstruction.text == "New instruction" {
//            selectedInstruction.text = ""
//        }
//        self.recipeInstructionsTableView.reloadData()
//    }
    
    
}
