//
//  RequestMainInfo.swift
//  MEO_EPG_Now_and_Next
//
//  Created by Albertino Vieira on 11/11/2019.
//  Copyright © 2019 alticeLabs. All rights reserved.
//

import Foundation

struct RequestMainInfo : Codable {
    var numberOfChannels: Int
    var odataNextlink: String

    init(
         numberOfChannels: Int ,
         odataNextlink: String ) {
        self.numberOfChannels = numberOfChannels
        self.odataNextlink = odataNextlink
    }
}
