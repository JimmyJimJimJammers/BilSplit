//
//  ItemsWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/1/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit


class ItemsWindow: UITableViewController
{
    override func viewDidLoad()
    {
        self.editableItemsList = [EditableItem(itemName: "Buffalo Wings", price: 3.50, quantity: 2), EditableItem(itemName: "Chicken Fingers", price: 2.75, quantity: 1)];
        super.viewDidLoad();
    }
    
    var editableItemsList : [EditableItem];
    
    override init()
    {
        editableItemsList = [];
        super.init();
    }
    init(itemList: [EditableItem])
    {
        editableItemsList = itemList;
        super.init();
    }
    required init(coder aDecoder: NSCoder)
    {
        editableItemsList = [];
        super.init(coder: aDecoder)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.editableItemsList.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var editItem : EditableItem;
        
        editItem = editableItemsList[indexPath.row];
        
        cell.textLabel?.text = editItem.ItemName;
        
        
        return cell;
    }//*/
}