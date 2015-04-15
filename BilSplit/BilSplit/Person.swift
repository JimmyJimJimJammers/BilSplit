//
//  Person.swift
//  BilSplit
//
//  Created by James McCarthy on 4/14/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class Person
{
    var name: String;// = "Name";
    var color: UIColor;// = UIColor.blackColor();
    var email: String;// = "NoEmail";
    var phone: String;//  = 5558675309;
    var items: [EditableItem];// = [];
    
    init(personName: String, personColor: UIColor, personEmail: String, phoneNumber: String, assignedItems: [EditableItem])
    {
        name = personName;
        color = personColor;
        email = personEmail;
        phone = phoneNumber;
        items = assignedItems;
    }
    init()
    {
        name = "Name";
        color = UIColor.blackColor();
        email = "NoEmail";
        phone  = "5558675309";
        items = [];
    }
}