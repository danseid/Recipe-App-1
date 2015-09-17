//
//  Instruction.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class Instruction: NSObject, NSCoding {
    
    var text: String
    var step: Int
    
    override init() {
        self.text = String()
        self.step = Int()
    }
    
    init(text: String, step: Int) {
        self.text = text
        self.step = step
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.text, forKey: "instructionText")
        coder.encodeObject(self.step, forKey: "instructionStep")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        self.text = decoder.decodeObjectForKey( "instructionText" ) as! String
        self.step = decoder.decodeObjectForKey( "instructionStep" ) as! Int
    }
}
