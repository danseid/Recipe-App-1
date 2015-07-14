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
    var icon: NSImage?
    
    override init() {
        self.name = String()
        self.desc = String()
        self.icon = NSImage()
    }
    
    init(name: String, desc: String?, icon: NSImage?) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }
}
