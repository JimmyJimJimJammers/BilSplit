//
//  ItemsWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/1/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation


class ItemsWindow: UITableViewController
{
    var editableItemsList : [EditableItem];
    
    override init()
    {
        editableItemsList = [];
    }
    init(itemList: [EditableItem])
    {
        editableItemsList = itemList;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.editableItemsList.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("EditableItemCell", forIndexPath: indexPath) as UITableViewCell
        var editItem : EditableItem;
        
        editItem = editableItemsList[indexPath.row];
        
        cell.textLabel?.text = editItem.ItemName;
    }
}