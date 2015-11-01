//
//  HospitalsCellViewControllerTableViewCell.swift
//  Inout2ThugLife
//
//  Created by Rohit Gurnani on 01/11/15.
//  Copyright © 2015 Rohit Gurnani. All rights reserved.
//

import UIKit

class HospitalsCellViewControllerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var phoneNo: UILabel!
    
    
    @IBOutlet weak var distance: UILabel!
    var hospital : Hospital! {
        didSet {
            
            name.text = hospital.name
            phoneNo.text = hospital.phoneNo
            distance.text = hospital.distance
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
