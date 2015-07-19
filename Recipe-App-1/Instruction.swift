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
        coder.encodeObject(self.text, forKey: "text")
        coder.encodeObject(self.step, forKey: "step")
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.text = decoder.decodeObjectForKey( "text" ) as! String
        self.step = decoder.decodeObjectForKey( "step" ) as! Int
    }
}
