//
//  Medicine.swift
//  Inout2ThugLife
//
//  Created by Rohit Gurnani on 31/10/15.
//  Copyright © 2015 Rohit Gurnani. All rights reserved.
//

import Foundation
import UIKit
struct Medicine {
    var name : String?
    var category : String?
    var price : Double?
    var cures : [String]
    var isAvailableWithoutPrescription : Bool?
    var image : String?
    
    init(name : String?, category : String?, price : Double?, cures : [String], isAvailableWithoutPrescription : Bool? , image : String?)
    {
        self.name = name
        self.category = category
        self.price = price
        self.cures = cures
        self.isAvailableWithoutPrescription = isAvailableWithoutPrescription
        self.image = image
    }
    
}