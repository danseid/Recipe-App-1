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
    
    var sidebarViewController: SidebarViewController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        // For debugging/convenience only:
        
//        self.sidebarViewController.setupNewRecipesCategory()
//        self.sidebarViewController.setupSampleRecipes()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("recipes")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("categories")
        
        // End of debugging code.
        
        if let recipes = NSUserDefaults.standardUserDefaults().objectForKey("recipes") as? NSData {
            if let unarchived = NSKeyedUnarchiver.unarchiveObjectWithData(recipes) as? [Recipe] {
                self.sidebarViewController.recipes = unarchived
            }
        } else {
            self.sidebarViewController.setupNewRecipesCategory()
            self.sidebarViewController.setupSampleRecipes()
        }
        
        if let categories = NSUserDefaults.standardUserDefaults().objectForKey("categories") as? NSData {
            self.sidebarViewController.categories = NSKeyedUnarchiver.unarchiveObjectWithData(categories) as! [Category]
        } else {
        }
        self.sidebarViewController.sidebarOutlineView.reloadData()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        self.sidebarViewController.saveData()
    }

}

