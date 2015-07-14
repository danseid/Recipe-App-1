//
//  DetailViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 07/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {

    @IBOutlet weak var recipeImageWell: NSImageView!
    @IBOutlet weak var recipeTextField: NSTextField!
    @IBOutlet weak var recipeIngredientsTableView: NSTableView!
    @IBOutlet weak var dropImageLabel: NSTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var displayRecipe: Recipe? {
        didSet {
            // Update the view.
            self.configureDisplayRecipe()
        }
    }
    
    func configureDisplayRecipe() {
        // Update the user interface for the detail item.
        if let recipe: Recipe = self.displayRecipe {
            self.recipeTextField.stringValue = recipe.title
            self.recipeImageWell.image = recipe.image
            if self.recipeImageWell.image != nil {
                self.dropImageLabel.stringValue = ""
            }
        }
    }
    
    @IBAction func recipeImageWellActive(sender: AnyObject) {
        self.displayRecipe!.image = self.recipeImageWell.image
    }
    
}
