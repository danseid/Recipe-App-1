//
//  Recipe.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Recipe: NSObject {
    
    var title: String
    var rating: Double
    var ingredients: IngredientsList
    var instructions: [Instruction]
    
    override init() {
        self.title = String()
        self.rating = 0.0
        self.ingredients = IngredientsList()
        self.instructions = [Instruction]()
    }
    
    init(title: String, rating: Double, ingredients: IngredientsList, instructions: [Instruction]) {
        self.title = title
        self.rating = rating
        self.ingredients = ingredients
        self.instructions = instructions
    }
}
