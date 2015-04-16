//
//  SelectPersonViewController.swift
//  BilSplit
//
//  Created by James McCarthy on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit

class SelectPersonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    var currPerson: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return people.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: PersonSelectCell = tableView.dequeueReusableCellWithIdentifier("PersonItemAsssignmentCell", forIndexPath: indexPath) as! PersonSelectCell
        
        var person : Person;
        person = people[indexPath.row];
        cell.NameLabel.text = person.name;
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "ToSignUpForItemsSegue")
        {
            var svc = segue.destinationViewController as! AssignItemsWindow;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            
            //sender.
        }
    }
}
