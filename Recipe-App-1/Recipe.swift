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
    var ingredients: [Ingredient]
    var instructions: [Instruction]
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
    
    init(name: String, rating: Double?, ingredients: [Ingredient], instructions: [Instruction], categories: [Category], image: NSImage?) {
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

    func encodeWithCoder(coder: NSCoder) {
            coder.encodeObject(self.name, forKey: "name")
            coder.encodeObject(self.rating, forKey: "rating")
            coder.encodeObject(self.ingredients, forKey: "ingredients")
            coder.encodeObject(self.instructions, forKey: "instructions")
            coder.encodeObject(self.categories, forKey: "categories")
            coder.encodeObject(self.image, forKey: "image")
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObjectForKey( "name" ) as! String
        self.rating = decoder.decodeObjectForKey( "rating" ) as! Double?
        self.ingredients = decoder.decodeObjectForKey( "ingreditents" ) as! [Ingredient]
        self.instructions = decoder.decodeObjectForKey( "instructions" ) as! [Instruction]
        self.categories = decoder.decodeObjectForKey( "categories" ) as! [Category]
        self.image = decoder.decodeObjectForKey( "image" ) as! NSImage?
    }
}

