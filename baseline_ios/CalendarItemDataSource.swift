//
//  CalendarItemDataSource.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 3/7/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON


class CalendarItemDataSource: Datasource, JSONDecodable {
    
    let calendar_items: [CalendarItem]
    
    required init(json: JSON) throws {
        let calendar_items_array = json["calendar_items"].array
        self.calendar_items = calendar_items_array!.map{CalendarItem(json: $0)}
    }
  
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return calendar_items[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return calendar_items.count
    }
    func numberOfWeekends() ->Int {
        return calendar_items.filter{
            $0.is_weekend == true
        }.count
    }
    func numberOfHolidays() -> Int{
        return calendar_items.filter{
            $0.is_holiday == true
            }.count
    }
    

}
