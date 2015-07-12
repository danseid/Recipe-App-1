//
//  IngredientsList.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Ingredient: NSObject {
    
    var name: String
    var quantity: Double
    var unit: unitEnum
    var preparation: String
    var notes: String
    
    override init() {
        self.name = String()
        self.quantity = Double()
        self.unit = unitEnum.none
        self.preparation = String()
        self.notes = String()
    }
    
    init(name: String, quantity: Double, unit: unitEnum, preparation: String, notes: String) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.preparation = preparation
        self.notes = notes
    }
    
    enum unitEnum {
        case none, kg, g, tbsp, tsp, l, ml
    }
    
}
