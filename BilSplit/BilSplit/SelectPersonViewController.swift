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
    var currPerson: Person = Person();
    var currPersonIndex: Int = 0;
    var historyList: [History] = [];
    var taxAmount: Double = 0;
    
    var totalItemsAssigned: Int = 0;
    var totalItems: Int = 0;
    
    @IBOutlet weak var DoneButton: UIButton!
    
    //Calls this function when the tap is recognized.
    /*func DismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }*/
    
    override func viewDidLoad()
    {
        /*//for dismissing the keyboard when tapping elsewhere
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)*/
        
        super.viewDidLoad()
        
        print("Total Items: " + String(totalItems) + "\n");
        print("Assigned Items: " + String(totalItemsAssigned) + "\n");
        
        // Do view setup here.
        if(totalItemsAssigned == totalItems)
        {
            DoneButton.enabled = true;
            //svc.DoneButton.userInteractionEnabled = true;
        }
        else
        {
            DoneButton.enabled = false
            //DoneButton.userInteractionEnabled = false;
            //DoneButton.
        }
        
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
        if(person.items.count > 0)
        {
            cell.DoneLabel.text = "✓";
        }
        else
        {
            cell.DoneLabel.text = "";
        }
        
        
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        currPerson = people[indexPath.row];
        currPersonIndex = indexPath.row;
        
        print("Person after click: " + currPerson.name + "\n");
        
        //call the segue here explicitly
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "ToSignUpForItemsSegue")
        {
            var svc = segue.destinationViewController as! AssignItemsWindow;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            svc.currPerson = self.currPerson;
            svc.currPersonIndex = self.currPersonIndex;
            svc.historyList = self.historyList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
        }
        if (segue.identifier == "ToFinalScreenSegue")
        {
            //delete people who have no items assigned to them
            for(var i: Int = 0; i < people.count; i++)
            {
                if(people[i].items.count < 1)
                {
                    people.removeAtIndex(i);
                    i--;
                }
            }
            
            
            var svc = segue.destinationViewController as! SummaryWindow;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            svc.historyList = self.historyList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
        }
        if(segue.identifier == "BackToAddPeopleSegue")
        {
            var svc = segue.destinationViewController as! AddPeopleViewController;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            svc.historyList = self.historyList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
        }
    }
}
