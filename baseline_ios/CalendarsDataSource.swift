//
//  CalendarsDataSource.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 14/7/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class CalendarsDataSource: Datasource, JSONDecodable {
    let calendars: [Calendar]
    required init(json: JSON) throws {
        let calendars_array_json = json["calendars"].array
        self.calendars = calendars_array_json!.map{Calendar(json: $0)}
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return calendars[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return calendars.count
    }
    override func cellClasses() -> [DatasourceCell.Type] {
        return [CalendarListCell.self]
    }
    
}
