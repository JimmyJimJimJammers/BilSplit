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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "AddPeoplePopUpSegue")
        {
            var svc = segue.destinationViewController as! AddPersonPopUp;

            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
        }
        if (segue.identifier == "BackToEditItemsSegue")
        {
            var svc = segue.destinationViewController as!  ItemsWindow;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
        }
        if (segue.identifier == "SelectPersonSegue")
        {
            var svc = segue.destinationViewController as!  SelectPersonViewController;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
        }
    }
}
