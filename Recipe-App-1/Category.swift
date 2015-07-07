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
    var desc: String
    
    override init() {
        self.name = String()
        self.desc = String()
    }
    
    init(name: String, desc: String) {
        self.name = name
        self.desc = desc
    }
}
