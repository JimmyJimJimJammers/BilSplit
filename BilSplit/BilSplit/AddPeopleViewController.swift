//
//  AddPeopleViewController.swift
//  BilSplit
//
//  Created by James McCarthy on 4/14/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit

class AddPeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    var historyList: [History] = [];
    var taxAmount: Double = 0;
    
    var totalItemsAssigned: Int = 0;
    var totalItems: Int = 0;
    
    @IBOutlet weak var FriendsTable: UITableView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.people.count;
    }
    
    func tableView(tView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: AddPeopleCell = tView.dequeueReusableCellWithIdentifier("AddPersonCell", forIndexPath: indexPath) as! AddPeopleCell
        
        var person : Person;
        person = people[indexPath.row];
        cell.NameLabel.text = person.name;
        cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            people.removeAtIndex(indexPath.row);
            FriendsTable.reloadData();
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "AddPeoplePopUpSegue")
        {
            var svc = segue.destinationViewController as! AddPersonPopUp;

            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            svc.historyList = self.historyList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
        }
        if (segue.identifier == "BackToEditItemsSegue")
        {
            var svc = segue.destinationViewController as!  ItemsWindow;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            svc.historyList = self.historyList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
        }
        if (segue.identifier == "SelectPersonSegue")
        {
            var svc = segue.destinationViewController as!  SelectPersonViewController;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            svc.historyList = self.historyList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
        }
    }
}
