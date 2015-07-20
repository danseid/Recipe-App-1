//
//  Recipe.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Recipe: NSObject {
    
    var name: String
    var rating: Double?
    var ingredients: [IngredientGroup: [Ingredient]]
    var ingredientGroups: [IngredientGroup]
    var instructions: [Instruction]
    var categories: [Category]
    var image: NSImage?
    
    override init() {
        self.name = String()
        self.rating = 0.0
        self.ingredients = [IngredientGroup: [Ingredient]]()
        self.ingredientGroups = [IngredientGroup]()
        self.instructions = [Instruction]()
        self.categories = [Category]()
        self.image = NSImage()
    }
    
    init(name: String, rating: Double?, ingredients: [IngredientGroup: [Ingredient]], instructions: [Instruction], categories: [Category], image: NSImage?) {
        self.name = name
        self.rating = rating
        self.ingredients = ingredients
        self.ingredientGroups = ingredients.keys.array.reverse()
        self.instructions = instructions
        self.categories = categories
        self.image = image
    }
    
    func addCategory(category: Category) {
        self.categories.append(category)
    }
    
    func removeCategory(category: Category) {
        self.categories = self.categories.filter({$0 != category})
    }
}
