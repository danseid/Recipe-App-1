//
//  IngredientsPopover.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 16/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class IngredientsPopover: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var ingredientsPopoverTableView: NSTableView!
    
    var ingredients: [AnyObject]!
    var expandedIngredients: [AnyObject] = [AnyObject]()
    var parentVC: NSViewController!
    var cancelled: Bool = false
    let rowType: String = "rowType"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //self.ingredientsPopoverTableView.headerView.
        self.expandIngredientGroups()
        //let registeredTypes:[String] = [NSStringPboardType]
        ingredientsPopoverTableView.registerForDraggedTypes([rowType, NSFilenamesPboardType])
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        if let parent = self.parentVC as? DetailViewController {
            self.collapseIngredientGroups()
            parent.editedRecipeIngredients = self.ingredients
            parent.returnFromIngredientsPopover(cancelled)
        }
    }
    
    func expandIngredientGroups() {
        for item in self.ingredients {
            self.expandedIngredients.append(item)
            if item is IngredientGroup {
                self.expandedIngredients.appendContentsOf(item.ingredients)
            }
        }
    }
    
    func collapseIngredientGroups() {
        var collapsedIngredients: [AnyObject] = [AnyObject]()
        for item in self.expandedIngredients {
            if let ingredient = item as? Ingredient {
                if !ingredient.inGroup {
                    collapsedIngredients.append(ingredient)
                }
            } else if let group = item as? IngredientGroup {
                collapsedIngredients.append(group)
            }
        }
        self.ingredients = collapsedIngredients
    }
    
    func findIngredientGroup(row: Int) -> (group: IngredientGroup?, index: Int?) { // Return group and the ingredient's position in the group
        for i in 0...row {
            if let group = self.expandedIngredients[row - i] as? IngredientGroup {
                return (group, i)
            }
        }
        return (nil,nil)
    }

    @IBAction func addIngredientButtonActive(sender: AnyObject) {
        let newIngredient: Ingredient = Ingredient(name: "New Ingredient", quantity: nil, unit: Ingredient.unitEnum.none, preparation: nil, notes: nil, inGroup: false)
        self.ingredientsPopoverTableView.beginUpdates()     //Use these to ensure the table animates appropriately when adding/removing rows
        var row: Int? = self.ingredientsPopoverTableView.selectedRow
        if row == nil || row < 0 {
            row = 0
        }
        if let group = self.expandedIngredients[row!] as? IngredientGroup {
            newIngredient.inGroup = true
            group.ingredients.append(newIngredient)
        }
        self.expandedIngredients.insert(newIngredient, atIndex: row! + 1)
        self.ingredientsPopoverTableView.insertRowsAtIndexes(NSIndexSet(index: row! + 1), withAnimation: NSTableViewAnimationOptions.SlideDown)
        self.ingredientsPopoverTableView.endUpdates()
    }
    
    @IBAction func addGroupButtonActive(sender: AnyObject) {
        let newGroup: IngredientGroup = IngredientGroup(name: "New Group", ingredients: [])
        self.ingredientsPopoverTableView.beginUpdates()
        var row: Int? = self.ingredientsPopoverTableView.selectedRow
        if row == nil || row < 0 {
            row = 0
        }
        self.expandedIngredients.insert(newGroup, atIndex: row! + 1)
        self.ingredientsPopoverTableView.insertRowsAtIndexes(NSIndexSet(index: row! + 1), withAnimation: NSTableViewAnimationOptions.SlideDown)
        self.ingredientsPopoverTableView.endUpdates()
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.characters == "\u{7F}" {    // Takes action if the 'delete' key is pressed while a row is selected
            let row: Int? = self.ingredientsPopoverTableView.selectedRow
            if row >= 0 {
                self.ingredientsPopoverTableView.beginUpdates()
                if let item = self.expandedIngredients[row!] as? IngredientGroup {
                    for _ in 0...item.ingredients.count {
                        self.expandedIngredients.removeAtIndex(row!)
                        self.ingredientsPopoverTableView.removeRowsAtIndexes(NSIndexSet(index: row!), withAnimation: NSTableViewAnimationOptions.SlideLeft)
                    }
                } else if let item = self.expandedIngredients[row!] as? Ingredient {
                    if item.inGroup {
                        let findGroup = self.findIngredientGroup(row!)
                        findGroup.group!.ingredients.removeAtIndex(findGroup.index! - 1)
                    }
                    self.expandedIngredients.removeAtIndex(row!)
                    self.ingredientsPopoverTableView.removeRowsAtIndexes(NSIndexSet(index: row!), withAnimation: NSTableViewAnimationOptions.SlideLeft)
                }
                self.ingredientsPopoverTableView.endUpdates()
            }
        }
    }
    
    @IBAction func doneButtonActive(sender: AnyObject) {
        self.dismissController(self)
    }
    
    @IBAction func cancelButtonActive(sender:AnyObject) {
        self.cancelled = true
        self.dismissViewController(self)
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.expandedIngredients.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        if let ingredient = self.expandedIngredients[row] as? Ingredient {
            if tableColumn!.identifier == "quantity" {
                return ingredient.quantity
            }
            else if tableColumn!.identifier == "unit" {
                return ingredient.unit!.rawValue
            }
            else if tableColumn!.identifier == "ingredient" {
                return ingredient.name
            }
            else if tableColumn!.identifier == "preparation"{
                return ingredient.preparation
            }
        } else if let ingredientGroup = self.expandedIngredients[row] as? IngredientGroup {
            if tableColumn!.identifier == "quantity" {
                return ingredientGroup.name
            }
        }
        return nil
    }

    func tableView(tableView: NSTableView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, row: Int) {
        if let ingredient = self.expandedIngredients[row] as? Ingredient {
            switch tableColumn!.identifier {
            case "quantity":
                let form: NSNumberFormatter = NSNumberFormatter()
                ingredient.quantity = form.numberFromString(object as! String)
            case "unit":
                ingredient.unit = Ingredient.unitEnum(rawValue: (object as? String)!)
            case "ingredient":
                ingredient.name = (object as? String)!
            default:
                ingredient.preparation = object as? String
            }
        } else if let ingredientGroup = self.expandedIngredients[row] as? IngredientGroup {
            if tableColumn!.identifier == "quantity" {
                ingredientGroup.name = (object as? String)!
            }
        }
    }
    
    func tableView(tableView: NSTableView, writeRowsWithIndexes rowIndexes: NSIndexSet, toPasteboard pboard: NSPasteboard) -> Bool {
        let data = NSKeyedArchiver.archivedDataWithRootObject([rowIndexes])
        pboard.declareTypes([rowType], owner:self)
        pboard.setData(data, forType:rowType)
        return true
    }
    
    func tableView(tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        tableView.setDropRow(row, dropOperation: NSTableViewDropOperation.Above)
        return NSDragOperation.Move
    }
    
    func tableView(tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
        let pboard = info.draggingPasteboard()
        let rowData = pboard.dataForType(rowType)
        
        if(rowData != nil) {
            let dataArray = NSKeyedUnarchiver.unarchiveObjectWithData(rowData!) as! Array<NSIndexSet>
            let indexSet = dataArray[0]
            let movingFromIndex = indexSet.firstIndex

            self.ingredientsPopoverTableView.beginUpdates()
            if let item = self.expandedIngredients[movingFromIndex] as? Ingredient {
                if item.inGroup {
                    let findMovingGroup = self.findIngredientGroup(movingFromIndex)
                    findMovingGroup.group!.ingredients.removeAtIndex(findMovingGroup.index! - 1)
                    item.inGroup = false
                }
                if row != 0 {
                    let findTargetGroup = self.findIngredientGroup(row - 1)
                    if findTargetGroup.group != nil {
                        findTargetGroup.group!.ingredients.insert(item, atIndex: findTargetGroup.index!)
                        item.inGroup = true
                    }
                }
                self.expandedIngredients.removeAtIndex(movingFromIndex)
                if row > self.expandedIngredients.count {
                    self.expandedIngredients.append(item)
                } else if row <= movingFromIndex {
                    self.expandedIngredients.insert(item, atIndex: row)
                } else {
                    self.expandedIngredients.insert(item, atIndex: row - 1)
                }
            }
            self.ingredientsPopoverTableView.endUpdates()
            return true
        } else {
            return false
        }
    }
    
}
