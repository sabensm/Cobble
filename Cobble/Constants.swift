//
//  Constants.swift
//  Cobble
//
//  Created by Sabens, Michael G. on 6/2/17.
//  Copyright © 2017 The New Thirty. All rights reserved.
//

import UIKit

let KEY_UID = "uid"

let PRIMARY_COLOR : UIColor = UIColor( red: 0.94, green: 0.33, blue: 0.31, alpha: 1.0 )

let TWITTER_APP_DEEPLINK = "twitter://user?screen_name=espn"

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

let date = Date()
let TIMESTAMP = date.toString(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
