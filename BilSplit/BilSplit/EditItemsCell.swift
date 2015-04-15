//
//  EditItemsCell.swift
//  BilSplit
//
//  Created by James McCarthy on 4/11/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit

class EditItemsCell: UITableViewCell
{
    @IBOutlet weak var QuantityField: QuantityTextField!
    
    @IBOutlet weak var ItemNameField: UITextField!
    
    @IBOutlet weak var CostField: UITextField!
    
    /*override func setEditing(editing: Bool, animated: Bool)
    {
        self.editing = editing;
    }*/
    
    func getEdited() -> Bool
    {
        if(QuantityField.getEditted())
        {
            return true;
        }
        return false;
    }
    
    /*
    var editing: Bool // show appropriate edit controls (+/- & reorder). By default -setEditing: calls setEditing:animated: with NO for animated.
    func setEditing(editing: Bool, animated: Bool)
    */
    
}