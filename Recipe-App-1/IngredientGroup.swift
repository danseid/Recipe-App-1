//
//  IngredientGroup.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 19/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class IngredientGroup: NSObject {
    
    var name: String
    var isExpanded: Bool
    
    override init() {
        self.name = String()
        self.isExpanded = Bool()
    }
    
    init(name: String) {
        self.name = name
        self.isExpanded = true
    }

}
