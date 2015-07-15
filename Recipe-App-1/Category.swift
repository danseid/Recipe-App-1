//
//  Category.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Category: NSObject {

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
    
    init(name: String, desc: String?, recipes: [Recipe]?, icon: NSImage?) {
        self.name = name
        self.desc = desc
        if let recs = recipes {
            self.recipes = recs
        } else {
            self.recipes = [Recipe]()
        }
        self.icon = icon
    }
    
    func addRecipe(recipe: Recipe) {
        self.recipes.append(recipe)
    }
    
    func removeRecipe(recipe: Recipe) {
        self.recipes = self.recipes.filter({$0 != recipe})
    }
}
