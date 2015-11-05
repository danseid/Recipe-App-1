//
//  AppDelegate.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 06/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var sidebarViewController: SidebarViewController!  //Instantiate a SidebarViewController, the 'hub' of the program

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // For debugging/convenience only:

        NSUserDefaults.standardUserDefaults().removeObjectForKey("recipes")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("categories")
        
        // End of debugging code.
        
        //Try to initialise Recipes from NSUserDefaults
        if let recipesData = NSUserDefaults.standardUserDefaults().objectForKey("recipes") as? NSData {
            if let unarchivedRecipes = NSKeyedUnarchiver.unarchiveObjectWithData(recipesData) as? [Recipe] {
                self.sidebarViewController.recipes = unarchivedRecipes
            }
        } else {  //If no Recipes are saved to NSUserDefaults, initialise with sample recipes and categories
            self.sidebarViewController.setupNewRecipesCategory()
            self.sidebarViewController.setupSampleRecipes()
        }
        
        //Try to initilise Categories from NSUserDefaults
        if let categories = NSUserDefaults.standardUserDefaults().objectForKey("categories") as? NSData {
            self.sidebarViewController.categories = NSKeyedUnarchiver.unarchiveObjectWithData(categories) as! [Category]
        }
        
        self.sidebarViewController.sidebarOutlineView.reloadData()  //Refresh the Sidebar OutlineView
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        
        self.sidebarViewController.saveData()  //Save recipes and categories to NSUserDefaults
    }

}

