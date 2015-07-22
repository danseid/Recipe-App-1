//
//  IngredientsList.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Ingredient: NSObject, NSCoding {
    
    var name: String
    var quantity: Double?
    var unit: unitEnum?
    var preparation: String?
    var notes: String?
    
    override init() {
        self.name = String()
        self.quantity = Double()
        self.unit = unitEnum.none
        self.preparation = String()
        self.notes = String()
    }
    
    init(name: String, quantity: Double?, unit: unitEnum?, preparation: String?, notes: String?) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.preparation = preparation
        self.notes = notes
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "ingredientName")
        coder.encodeObject(self.quantity, forKey: "ingredientQuantity")
        coder.encodeObject(self.unit?.rawValue, forKey: "ingredientUnit" )
        coder.encodeObject(self.preparation, forKey: "ingredientPreparation")
        coder.encodeObject(self.notes, forKey: "ingredientNotes")
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.name = decoder.decodeObjectForKey( "ingredientName" ) as! String
        self.quantity = decoder.decodeObjectForKey( "ingredientQuantity" ) as! Double?
        self.unit = unitEnum(rawValue: decoder.decodeObjectForKey("ingredientUnit" ) as! String )
        self.preparation = decoder.decodeObjectForKey( "ingredientPreparation" ) as! String?
        self.notes = decoder.decodeObjectForKey( "ingredientNotes" ) as! String?
    }
    
    enum unitEnum : String {
        case none = "",
        kg = "kg",
        g = "g",
        tbsp = "tbsp",
        tsp = "tsp",
        l = "l",
        ml = "ml"
    }
    
    func tableDisplayString() -> String {  // Return a ingredient format to display in DetailView table
        var integerQuantity: Int
        if let quantity = self.quantity as Double? {
            if quantity % 1.0 == 0 {  // Avoid unnecessary decimal points
                integerQuantity = Int(quantity)
                if let unit = self.unit as unitEnum? {
                    return "\(integerQuantity)" + unit.rawValue + " " +  self.name
                } else {
                    return "\(integerQuantity)" + self.name
                }
            } else {
                if let unit = self.unit as unitEnum? {
                    return "\(quantity)" + unit.rawValue + " " + self.name
                } else {
                    return "\(quantity)" + self.name
                }
            }
        }
        return self.name
    }
    
}
