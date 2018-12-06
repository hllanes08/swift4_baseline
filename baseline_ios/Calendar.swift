//
//  Calendar.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 14/7/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//

import Foundation
import SwiftyJSON

class Calendar {
    let id: Int
    let name: String
    let start_date: Date
    let n_days: Int
    
    init(json: JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        let start_date_string = json["start_date"].stringValue
        start_date = Calendar.convertToLocal(dateString: start_date_string)
        n_days = json["n_days"].intValue
    }
    
    static func convertToLocal(dateString: String) -> Date {
        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd"
        return dateformater.date(from: dateString)!
    }

}
