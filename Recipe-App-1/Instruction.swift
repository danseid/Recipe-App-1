//
//  Instruction.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Instruction: NSObject {
    
    var text: String
    
    override init() {
        self.text = String()
    }
    
    init(text: String) {
        self.text = text
    }
}
