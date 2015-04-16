//
//  History.swift
//  BilSplit
//
//  Created by Miguel Hummel on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class History {
    var people:[Person]
    var tax:Double
    var total:Double
    var location:String
    
    init(people: [Person], tax: Double, total: Double, location: String)
    {
        self.people = people;
        self.tax = tax;
        self.total =  total;
        self.location = location;
    }
    
    init()
    {
        self.people = [];
        self.tax = 0.0;
        self.total = 0.0;
        self.location = ""
    }
}