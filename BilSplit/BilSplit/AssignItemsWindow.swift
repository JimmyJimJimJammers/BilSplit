//
//  AssignItemsWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class AssignItemsWindow: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return editableItemsList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: ItemSelectCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("PersonItemAsssignmentCell", forIndexPath: indexPath) as! ItemSelectCellTableViewCell
        
        var item : EditableItem;
        item = editableItemsList[indexPath.row];
        
        //cell.NameLabel.text = person.name;
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
}
