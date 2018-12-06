//
//  CalendarItem.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 3/7/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CalendarItem {
    let id: Int
    let start_event_date: Date
    let end_event_date: Date
    let is_weekend: Bool
    let is_holiday: Bool
 
    init(json: JSON)  {
        id = json["id"].intValue
        start_event_date = CalendarItem.convertToLocal(dateString: json["start_event_date"].stringValue)
        end_event_date = CalendarItem.convertToLocal(dateString: json["end_event_date"].stringValue)
        is_weekend = json["is_weekend"].boolValue
        is_holiday = json["is_holiday"].boolValue
    }
    
    static func convertToLocal(dateString: String) -> Date {
        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateformater.locale = Locale(identifier: "en_US_POSIX")
        let secondsDiff = (-1 * Double(TimeZone.current.secondsFromGMT()))
        return dateformater.date(from: dateString)!.addingTimeInterval(secondsDiff)
    }
}
