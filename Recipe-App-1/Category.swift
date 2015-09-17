//
//  Category.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Category: NSObject, NSCoding {

    var name: String
    var desc: String?
    var recipes: [Recipe]
    var icon: NSImage?
    
    override init() {
        self.name = String()
        self.desc = String()
        self.recipes = [Recipe]()
        self.icon = NSImage()
    }
    
    init(name: String, desc: String?, recipes: [Recipe], icon: NSImage?) {
        self.name = name
        self.desc = desc
        self.recipes = recipes
        self.icon = icon
    }
    
    func addRecipe(recipe: Recipe) {
        self.recipes.append(recipe)
    }
    
    func removeRecipe(recipe: Recipe) {
        self.recipes = self.recipes.filter({$0 != recipe})
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "categoryName")
        coder.encodeObject(self.desc, forKey: "categoryDesc")
        coder.encodeObject(self.recipes, forKey: "categoryRecipes")
        coder.encodeObject(self.icon, forKey: "categoryIcon")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObjectForKey( "categoryName" ) as! String
        self.desc = decoder.decodeObjectForKey( "categoryDesc" ) as! String?
        self.recipes = decoder.decodeObjectForKey( "categoryRecipes" ) as! [Recipe]
        self.icon = decoder.decodeObjectForKey( "categoryIcon" ) as! NSImage?
    }
}
