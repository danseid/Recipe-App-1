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
    
    enum unitEnum {
        case none, kg, g, tbsp, tsp, l, ml
    }
    
    func unitDisplayString() -> String {  // Return the display format of the unit type
        switch self.unit! {
        case .none: return ""
        case .kg:   return "kg"
        case .g:    return "g"
        case .tbsp: return "tbsp"
        case .tsp:  return "tsp"
        case .l:    return "l"
        case .ml:    return "ml"
        default:
            return ""
        }
    }
    
    func tableDisplayString() -> String {  // Return a ingredient format to display in DetailView table
        var integerQuantity: Int
        if let quantity = self.quantity as Double? {
            if quantity % 1.0 == 0 {  // Avoid unnecessary decimal points
                integerQuantity = Int(quantity)
                if let unit = self.unit as unitEnum? {
                    return "\(integerQuantity)" + unitDisplayString() + " " +  self.name
                } else {
                    return "\(integerQuantity)" + self.name
                }
            } else {
                if let unit = self.unit as unitEnum? {
                    return "\(quantity)" + unitDisplayString() + " " + self.name
                } else {
                    return "\(quantity)" + self.name
                }
            }
        }
        return self.name
    }
    
}
