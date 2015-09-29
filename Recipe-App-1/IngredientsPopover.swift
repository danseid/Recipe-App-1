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
    var originalIngredients: [AnyObject] = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        //self.ingredientsPopoverTableView.headerView.
        self.expandIngredientGroups()
        self.originalIngredients = self.expandedIngredients
    }
    
    func expandIngredientGroups() {
        for item in self.ingredients {
            self.expandedIngredients.append(item)
            if item is IngredientGroup {
                self.expandedIngredients.appendContentsOf(item.ingredients)
            }
        }
    }
    @IBAction func cancelButtonActive(sender: AnyObject) {
        self.expandedIngredients = self.originalIngredients
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
            else {
                return ingredient.preparation!
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
}
