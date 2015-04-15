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
    //suck this dick, you suck one too
    var people: [Person] = [];
    var personToAdd: Person!;
    var editableItemsList: [EditableItem] = []
    var dataPassed: [EditableItem]!
    var colors: ColorPresets = ColorPresets();
    
    @IBOutlet weak var FriendsTable: UITableView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let y = dataPassed
        if (y != nil){
            editableItemsList = dataPassed;
        }
        // Do any additional setup after loading the view.
        
        /*println("Added Jim to people");
        people.append(Person(personName: "Jim", personColor: UIColor.blackColor(), personEmail: "McCarthyj10@aol.com", phoneNumber: "17742499626", assignedItems: []));*/
        
        let x = personToAdd;
        if(x != nil)
        {
            println("Added A Person to people");
            people.append(personToAdd);
        }
        
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
            
            svc.people = self.people;
            svc.colors = self.colors;
            //svc.NameTextField = NameTextField.text
            //svc = fieldB.text
        }
        /*if (segue.identifier == "SelectPersonSegue") {
        var svc = segue.destinationViewController as!  PersonSelectViewController;
        svc.dataPassed = editableItemsList
        }
        if (segue.identifier == "BackToEditItemsSegue") {
            var svc = segue.destinationViewController as!  ItemsWindow;
            svc.dataPassedBack = editableItemsList
        }*/
    }
}
