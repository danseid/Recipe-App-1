//
//  CategoryCollectionViewController.swift
//  Recipe-App-1
//
//  Created by Hlynur Sveinbjörnsson on 24/07/2015.
//  Copyright (c) 2015 Hlynur Sveinbjörnsson. All rights reserved.
//

import Cocoa

class CategoryCollectionViewController: NSViewController, NSCollectionViewDelegate {
    
    @IBOutlet weak var categoryCollectionView: NSCollectionView!
    @IBOutlet weak var categoryCollectionViewArray: NSArrayController!
    
    var displayCategory: Category = Category()
    var displayImages: NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.categoryCollectionView.itemPrototype = self.storyboard?.instantiateControllerWithIdentifier("categoryCollectionViewItem") as? NSCollectionViewItem
    }
    
    func displaySelectedCategory() {
        self.displayImages.removeAllObjects()
        for recipe in self.displayCategory.recipes {
            self.categoryCollectionViewArray.addObject(recipe as Recipe)
        }
    }

}
