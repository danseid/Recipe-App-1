//
//  SidebarViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController{//, NSOutlineViewDelegate, NSOutlineViewDataSource {
    
    @IBOutlet weak var sidebarSearchField: NSSearchField!
    @IBOutlet weak var sidebarOutlineView: NSOutlineView!
    
    var recipes = [Category: [Recipe]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setupSampleRecipes() {
        let sampleRecipe1 = Recipe(title: "Salmon", rating: 4.0, ingredients: [Ingredient(name: "Salmon Fillets", quantity: 2.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [Category(name: "Fish", desc: "Fish dishes", icon: NSImage())], pictures: [NSImage(named: "Salmon")])
        let sampleRecipe2 = Recipe(title: "Tuna", rating: 3.0, ingredients: [Ingredient(name: "Tuna Fillets", quantity: 2.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [Category(name: "Fish", desc: "Fish dishes", icon: NSImage())], pictures: [NSImage(named: "Tuna")])
        let sampleRecipe3 = Recipe(title: "Paella", rating: 5.0, ingredients: [Ingredient(name: "Chicken Thighs", quantity: 4.0, unit: Ingredient.unitEnum.none, preparation: "", notes: ""), Ingredient(name: "Green Beans", quantity: 100.0, unit: Ingredient.unitEnum.g, preparation: "", notes: "")], instructions: [Instruction(text: "Do stuff and such.", step: 1)],categories: [Category(name: "Rice Dishes", desc: "Rice dishes", icon: NSImage())], pictures: [NSImage(named: "Paella")])
        
        let sampleCategory = Category(name: "Sample Category", desc: "This is a sample", icon: NSImage())
        
        recipes = [sampleCategory: [sampleRecipe1, sampleRecipe2, sampleRecipe3]]
    }
    

    @IBAction func deleteRecipeButtonActive(sender: AnyObject) {
    }

    @IBAction func addRecipeButtonActive(sender: AnyObject) {
    }
    
    @IBAction func sidebarSearchFieldActive(sender: AnyObject) {
    }
    
//    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
//        <#code#>
//    }
//    
//    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
//        if let it = item as?
//    }
//    
//    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
//
//    }
//    
//    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
//        <#code#>
//    }
}
