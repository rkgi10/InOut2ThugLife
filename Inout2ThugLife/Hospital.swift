//
//  Hospital.swift
//  Inout2ThugLife
//
//  Created by Rohit Gurnani on 01/11/15.
//  Copyright © 2015 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit

struct Hospital {
    var name : String!
    var phoneNo : String!
    var distance : String!
    var image : UIImage!
    
    init(name:String, phoneNo : String, distance : String, image : String)
    {
        self.name = name
        self.phoneNo = phoneNo
        self.distance = distance
        self.image = UIImage(contentsOfFile: image)
    }
}