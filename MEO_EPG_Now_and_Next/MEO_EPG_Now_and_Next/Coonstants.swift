//
//  Coonstants.swift
//  MEO_EPG_Now_and_Next
//
//  Created by Albertino Vieira on 11/11/2019.
//  Copyright © 2019 alticeLabs. All rights reserved.
//

import Foundation

struct ConstantsStruct {
        static let firstPage = "https://ott.online.meo.pt/catalog/v7/Channels?UserAgent=AND&$filter=substringof(%27MEO_Mobile%27,AvailableOnChannels)%20and%20IsAdult%20eq%20false&$orderby=ChannelPosition%20asc&$inlinecount=allpages"
       static let nextPage = "https://ott.online.meo.pt/catalog/v7/Channels?$format=json&UserAgent=AND&$filter=substringof%28%27MEO_Mobile%27%2CAvailableOnChannels%29%20and%20IsAdult%20eq%20false&$orderby=ChannelPosition%20asc&$inlinecount=allpages&$skip="
    
    static let epgChannel = "https://ott.online.meo.pt/Program/v7/Programs/NowAndNextLiveChannelPrograms?UserAgent=IOS&$filter=CallLetter%20eq%20%27"
    static let epgChannel2 = "%27&$orderby=StartDate%20asc"
    static let reuseIdentifier = "cellChannel"
    
    static let imgUrl = "http://proxycache.app.iptv.telecom.pt:8080/eemstb/ImageHandler.ashx?evTitle="
    static let imgUrl2 = "&chCallLetter="
    static let imgUrl3 = "&profile=16_9&width=320"
    }

