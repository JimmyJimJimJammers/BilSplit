//
//  HistoryDetailViewController.swift
//  BilSplit
//
//  Created by Miguel Hummel on 4/29/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    var resturant:History!
    var tax:Double = 0.0;
    
    @IBOutlet weak var ResturantName: UILabel!
    @IBOutlet weak var Total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        ResturantName.text = resturant.location;
        Total.text = String(format: "Total: $%.2f", resturant.total);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return resturant.people.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let tcell: HistoryDetailTableCell = tableView.dequeueReusableCellWithIdentifier("ViewHistoryCell", forIndexPath: indexPath) as! HistoryDetailTableCell
        
        var person :Person;
        person = resturant.people[indexPath.row];
        tcell.Name.text = person.name;
        
        var total: Double = 0;
        for(var i: Int = 0; i < person.items.count; i++)
        {
            total += person.items[i].Price;
        }
        total += total*resturant.tax;
        total += total*person.tip;
        
        tcell.Total.text = String(format: "$%.2f", total);
        tcell.Color.backgroundColor = person.color;
        return tcell;
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
