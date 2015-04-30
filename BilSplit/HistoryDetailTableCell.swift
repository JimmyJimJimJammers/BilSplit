//
//  HistoryDetailTableCell.swift
//  BilSplit
//
//  Created by Miguel Hummel on 4/29/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class HistoryDetailTableCell: UITableViewCell
{
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var Color: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
