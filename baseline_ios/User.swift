//
//  User.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 17/7/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    let id:Int
    let email:String
    let auth_token:String
    let expires_token_at:Date
    
    init(json: JSON){
        id = json["id"].intValue
        email = json["email"].stringValue
        auth_token = json["auth_token"].stringValue
        let expire_date_string = json["expires_token_at"].stringValue
        if(!expire_date_string.isEmpty){
            expires_token_at = CalendarItem.convertToLocal(dateString: expire_date_string)
        }else{
            expires_token_at = Date()
        }
    }

}
