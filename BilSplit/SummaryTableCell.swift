//
//  SummaryTableCell.swift
//  
//
//  Created by James McCarthy on 4/15/15.
//
//

import UIKit

class SummaryTableCell: UITableViewCell
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
