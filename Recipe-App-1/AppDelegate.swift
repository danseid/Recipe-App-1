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
        
//        self.sidebarViewController.setupNewRecipesCategory()
//        self.sidebarViewController.setupSampleRecipes()
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("recipes")
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("categories")
        
        if let recipes = NSUserDefaults.standardUserDefaults().objectForKey("recipes") as? NSData {
            sidebarViewController.recipes = NSKeyedUnarchiver.unarchiveObjectWithData(recipes) as! [Recipe]
        } else {
            sidebarViewController.setupNewRecipesCategory()
            sidebarViewController.setupSampleRecipes()
        }
        
        if let categories = NSUserDefaults.standardUserDefaults().objectForKey("categories") as? NSData {
            sidebarViewController.categories = NSKeyedUnarchiver.unarchiveObjectWithData(categories) as! [Category]
        } else {
        }
        self.sidebarViewController.sidebarOutlineView.reloadData()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        self.sidebarViewController.saveData()
    }

}

