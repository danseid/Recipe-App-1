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
    var step: String
    
    override init() {
        self.text = String()
        self.step = String()
    }
    
    init(text: String, step: String) {
        self.text = text
        self.step = step
    }
}
