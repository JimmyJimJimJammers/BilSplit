//
//  QuantityTextField.swift
//  BilSplit
//
//  Created by James McCarthy on 4/11/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class QuantityTextField: UITextField
{
    var edit:Bool = false;
    
    func getEditted() -> Bool
    {
        if(edit)
        {
            edit = false;
            return true;
        }
        return false;
    }
}