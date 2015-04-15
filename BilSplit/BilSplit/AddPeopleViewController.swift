//
//  AddPeopleViewController.swift
//  BilSplit
//
//  Created by James McCarthy on 4/14/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class AddPeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var people: [Person] = [];
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: AddPeopleCell = tableView.dequeueReusableCellWithIdentifier("AddPeopleCell", forIndexPath: indexPath) as! AddPeopleCell
        var person : Person;
        
        person = people[indexPath.row];
        
        cell.NameLabel.text = person.name;
        cell.ColorLabel.backgroundColor = person.color;
        
        /*
        @IBOutlet weak var NameLabel: UILabel!
        @IBOutlet weak var ColorLabel: UILabel!
        */
        
        //cell.NameLabel.text = "";
        //cell.ColorLabel.backgroundColor = colorPallette;
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "AddPeopleViewController.swift")
        {
            var svc = segue.destinationViewController as! AddPeopleViewController;
            //svc.NameTextField = NameTextField.text
            //svc = fieldB.text
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}