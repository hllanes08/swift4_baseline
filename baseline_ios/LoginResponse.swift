//
//  LoginResponse.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 17/7/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginResponse{
    let success:Bool
    let errors:String
    let statusCode:Int
    let user:User
    init(json: JSON){
        success = json["success"].boolValue
        errors = json["errors"].stringValue.isEmpty ? json["error"].stringValue : json["errors"].stringValue
        user = User(json: json["user"])
        statusCode = json["status"].intValue
    }
}
