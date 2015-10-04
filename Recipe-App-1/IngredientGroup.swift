//
//  IngredientGroup.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 19/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class IngredientGroup: NSObject, NSCoding {
    
    var name: String
    var ingredients: [Ingredient]
    var isExpanded: Bool
    
    required override init() {
        self.name = String()
        self.ingredients = [Ingredient]()
        self.isExpanded = Bool()
    }
    
    init(name: String, ingredients: [Ingredient]) {
        self.name = name
        self.ingredients = ingredients
        self.isExpanded = true
    }
    
    override func copy() -> AnyObject {
        let ingredientsGroupCopy = self.dynamicType.init()
        ingredientsGroupCopy.name = self.name
        ingredientsGroupCopy.ingredients = self.ingredients
        ingredientsGroupCopy.isExpanded = self.isExpanded
        return ingredientsGroupCopy
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "ingredientGroupName")
        coder.encodeObject(self.ingredients, forKey: "ingredientGroupIngredients")
        coder.encodeObject(self.isExpanded, forKey: "ingredientGroupIsExpanded")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObjectForKey( "ingredientGroupName" ) as! String
        self.ingredients = decoder.decodeObjectForKey("ingredientGroupIngredients") as! [Ingredient]
        self.isExpanded = decoder.decodeObjectForKey( "ingredientGroupIsExpanded" ) as! Bool
    }

}
