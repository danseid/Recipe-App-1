//
//  IngredientsList.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class IngredientsList: NSObject {
    
    var ingredientNames: [String]
    
    override init() {
        self.ingredientNames = [String]()
    }
    
    init(ingredientNames: [String]) {
        self.ingredientNames = ingredientNames
    }
}
