//
//  Recipe.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Recipe: NSObject, NSCoding {
    
    var name: String
    var rating: Double?
    var ingredients: [AnyObject]
    var instructions: [Instruction]
    var categories: [Category]
    var image: NSImage?
    
    override init() {
        self.name = String()
        self.rating = 0.0
        self.ingredients = [AnyObject]()
        self.instructions = [Instruction]()
        self.categories = [Category]()
        self.image = NSImage()
    }
    
    init(name: String, rating: Double?, ingredients: [AnyObject], instructions: [Instruction], categories: [Category], image: NSImage?) {
        self.name = name
        self.rating = rating
        self.ingredients = ingredients
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
    
    func copyIngredients() -> [AnyObject] {
        var ingredientsCopy: [AnyObject] = [AnyObject]()
        for object in self.ingredients {
            if let ingredient = object as? Ingredient {
                ingredientsCopy.append(ingredient.copy())
            } else if let ingredientGroup = object as? IngredientGroup {
                ingredientsCopy.append(ingredientGroup.copy())
            }
        }
        return ingredientsCopy
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "recipeName")
        coder.encodeObject(self.rating, forKey: "recipeRating")
        coder.encodeObject(self.ingredients, forKey: "recipeIngredients")
        coder.encodeObject(self.instructions, forKey: "recipeInstructions")
        coder.encodeObject(self.categories, forKey: "recipeCategories")
        coder.encodeObject(self.image, forKey: "recipeImage")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObjectForKey( "recipeName" ) as! String
        self.rating = decoder.decodeObjectForKey( "recipeRating" ) as! Double?
        self.ingredients = decoder.decodeObjectForKey("recipeIngredients") as! [AnyObject]
        self.instructions = decoder.decodeObjectForKey( "recipeInstructions" ) as! [Instruction]
        self.categories = decoder.decodeObjectForKey( "recipeCategories" ) as! [Category]
        self.image = decoder.decodeObjectForKey( "recipeImage" ) as! NSImage?
    }
}

