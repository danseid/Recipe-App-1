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
    
    override init() {  //Override NSObject default initialiser
        self.name = String()
        self.rating = 0.0
        self.ingredients = [AnyObject]()
        self.instructions = [Instruction]()
        self.categories = [Category]()
        self.image = NSImage()
    }
    
    //Default constructor
    init(name: String, rating: Double?, ingredients: [AnyObject], instructions: [Instruction], categories: [Category], image: NSImage?) {
        self.name = name
        self.rating = rating
        self.ingredients = ingredients
        self.instructions = instructions
        self.categories = categories
        self.image = image
    }
    
    //Add a category to the Recipe
    func addCategory(category: Category) {
        self.categories.append(category)
    }
    
    //Remove a category from the Recipe, must do by filtering category list
    func removeCategory(category: Category) {
        self.categories = self.categories.filter({$0 != category})  //Filter removes matching objects
    }
    
    //Implement NSCopying for the list of Ingredients in order to pass-by-value
    func copyIngredients() -> [AnyObject] {
        var ingredientsCopy: [AnyObject] = [AnyObject]()
        for object in self.ingredients {
            if let ingredient = object as? Ingredient {  //Must discern whether Ingredient or IngredientGroup to use correct NSCopying implementation
                ingredientsCopy.append(ingredient.copy())
            } else if let ingredientGroup = object as? IngredientGroup {
                ingredientsCopy.append(ingredientGroup.copy())
            }
        }
        return ingredientsCopy
    }

    //Impelmentation NSCoding to allow Recipe to be saved to NSUserDefaults
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "recipeName")
        coder.encodeObject(self.rating, forKey: "recipeRating")
        coder.encodeObject(self.ingredients, forKey: "recipeIngredients")
        coder.encodeObject(self.instructions, forKey: "recipeInstructions")
        coder.encodeObject(self.categories, forKey: "recipeCategories")
        coder.encodeObject(self.image, forKey: "recipeImage")
    }
    
    //Implementation of NSCoding to retrieve Recipe from NSUserDefaults
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

