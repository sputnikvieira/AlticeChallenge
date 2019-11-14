//
//  ChannelTableViewCell.swift
//  MEO_EPG_Now_and_Next
//
//  Created by Albertino Vieira on 11/11/2019.
//  Copyright © 2019 alticeLabs. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    
    @IBOutlet weak var channelImg: UIImageView!
    
    @IBOutlet weak var channelTitle: UILabel!
    
    @IBOutlet weak var nowProgramChannel: UILabel!
    
    @IBOutlet weak var nextProgramChannel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configuer(chanel: Channel){
        
    }

}
