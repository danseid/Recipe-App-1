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
    var rating: Double?
    var ingredients: [Ingredient]?
    var instructions: [Instruction]?
    var categories: [Category]?
    var image: NSImage?
    
    override init() {
        self.title = String()
        self.rating = 0.0
        self.ingredients = [Ingredient]()
        self.instructions = [Instruction]()
        self.categories = [Category]()
        self.image = NSImage()
    }
    
    init(title: String, rating: Double?, ingredients: [Ingredient]?, instructions: [Instruction]?, categories: [Category]?, image: NSImage?) {
        self.title = title
        self.rating = rating
        self.ingredients = ingredients
        self.instructions = instructions
        self.categories = categories
        self.image = image
    }
}
