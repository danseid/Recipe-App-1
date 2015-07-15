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
    var ingredients: [Ingredient]?
    var instructions: [Instruction]?
    var categories: [Category]
    var image: NSImage?
    
    override init() {
        self.name = String()
        self.rating = 0.0
        self.ingredients = [Ingredient]()
        self.instructions = [Instruction]()
        self.categories = [Category]()
        self.image = NSImage()
    }
    
    init(name: String, rating: Double?, ingredients: [Ingredient]?, instructions: [Instruction]?, categories: [Category]?, image: NSImage?) {
        self.name = name
        self.rating = rating
        self.ingredients = ingredients
        self.instructions = instructions
        if let cats = categories {
            self.categories = cats
        } else {
            self.categories = [Category]()
        }
        self.image = image
    }
    
    func addCategory(category: Category) {
        self.categories.append(category)
    }
    
    func removeCategory(category: Category) {
        self.categories = self.categories.filter({$0 != category})
    }
}
