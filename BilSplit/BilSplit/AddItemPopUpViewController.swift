//
//  AddItemPopUpViewController.swift
//  BilSplit
//
//  Created by Miguel Hummel on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class AddItemPopUpViewController: UIViewController {

    @IBOutlet weak var PriceField: UITextField!
    @IBOutlet weak var ItemNameField: UITextField!
    @IBOutlet weak var QuantityField: UITextField!
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    var historyList: [History] = [];
    var taxAmount: Double = 0;
    var totalItemsAssigned: Int = 0;
    var totalItems: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "BackToItemsWindow")
        {
            var svc = segue.destinationViewController as! ItemsWindow;
            
            var p = String(PriceField.text)
            var n = String(ItemNameField.text)
            var q = String(QuantityField.text)
            q = q.stringByReplacingOccurrencesOfString("x", withString: "", options: nil, range: nil);
            p = p.stringByReplacingOccurrencesOfString("$", withString: "", options: nil, range: nil);
            var quantInt : Int = 0;
            var priceD : Double = 0;
            if let myNumber = NSNumberFormatter().numberFromString(q) {
                quantInt = q.toInt()!;
            }
            if let myNumber = NSNumberFormatter().numberFromString(p) { //<- not sure if works with '.' in number
                priceD = NSString(string: p).doubleValue;
            }
            self.editableItemsList.append(EditableItem(itemName: n, price: priceD, quantity: quantInt, assigned:0))
            
            var x = Item()
            x.price = priceD
            x.quantity = quantInt
            x.name = n
            finalReceipt.items.append(x)
            
            svc.people = self.people;
            svc.historyList = self.historyList;
            svc.colors = self.colors;
            svc.editableItemsList = self.editableItemsList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
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
