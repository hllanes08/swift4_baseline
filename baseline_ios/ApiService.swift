    //
//  ApiService.swift
//  ios_baseline
//
//  Created by Harvin Llanes on 5/6/17.
//  Copyright © 2017 Harvin Llanes. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON
import SwiftKeychainWrapper

struct ApiService {
    let tron = TRON(baseURL: "http://ec2-52-89-198-196.us-west-2.compute.amazonaws.com/api/v1")
    //let tron = TRON(baseURL: "http://localhost:3000/api/v1")
    
    static let sharedInstance = ApiService()
    static var loginResponse:LoginResponse!
    
    class JSONError: JSONDecodable {
        var errors: [String:[String]] = [:]
        required init(json: JSON) {
            loginResponse = LoginResponse(json:json)
            if let dictionary = json["errors"].dictionary {
                for (key,value) in dictionary {
                    errors[key] = value.arrayValue.map( { return $0.stringValue } )
                }
            }
        }
    }
    
    class Token: JSONDecodable {
        let token: String
        required init(json: JSON) throws {
            loginResponse = LoginResponse(json:json)
            self.token = json["user"]["auth_token"].stringValue
            KeychainWrapper.standard.set(self.token, forKey: "token")
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (LoginResponse) ->()){
        let parameters: [String : Any] = [
            "session": [
                "email": email,
                "password": password
            ]
        ]
        
        KeychainWrapper.standard.removeObject(forKey: "token")
        let request: APIRequest<Token, JSONError> = tron.swiftyJSON.request("/sessions")
        request.method = .post
        request.parameters = parameters
        request.perform(withSuccess: { (tokenData) in
            if(!tokenData.token.isEmpty){
                completion(ApiService.loginResponse)
            }
            
        }) { (error) in
            if let data = error.data {
              do{
                try print(JSON(data: data))
              }catch{
                  print(error.localizedDescription)
              }
            }
            completion(ApiService.loginResponse)
        }
    }
    
    func fetchCalendarItems(calendarId: Int, completion: @escaping (CalendarItemDataSource) -> ()){
        let token  = KeychainWrapper.standard.string(forKey: "token")
        if(token != nil){
          self.tron.headerBuilder = HeaderBuilder(defaultHeaders: ["Authorization": token!])
        }
        let request: APIRequest<CalendarItemDataSource, JSONError> = tron.swiftyJSON.request("/calendar/\(calendarId)")
        request.perform(withSuccess: { (calendarItemsDataSource) in
            completion(calendarItemsDataSource)
        }) { (err) in
            print("failed to fetch json...", err)
        }

    }
    
    func fetchCalendars(completion: @escaping (CalendarsDataSource) -> ()){
        let token  = KeychainWrapper.standard.string(forKey: "token")
        if(token != nil){
            self.tron.headerBuilder = HeaderBuilder(defaultHeaders: ["Authorization": token!])
        }
        
        let request: APIRequest<CalendarsDataSource, JSONError> = tron.swiftyJSON.request("/calendar")
        request.perform(withSuccess: { (calendarsDataSource) in
            completion(calendarsDataSource)
        }) { (err) in
            print("failed to fetch json...", err)
        }
    }
    
    func addCalendar(name: String, startDate: String, endDate:String, ndays:String,completion: @escaping (Bool) -> ())  {
        let parameters: [String : Any] = [
                "start_date": startDate,
                "name": name,
                "ndays": ndays
        ]
        
        let token  = KeychainWrapper.standard.string(forKey: "token")
        if(token != nil){
            self.tron.headerBuilder = HeaderBuilder(defaultHeaders: ["Authorization": token!])
        }
        let request: APIRequest<String, JSONError> = tron.swiftyJSON.request("/calendar")
        request.method = .post
        request.parameters = parameters
        request.perform(withSuccess: { (response) in
            print(response)
            completion(true)
        }) { (err) in
            print("failed to fetch json...", err)
            completion(false)
        }
    }
    
    func deleteCalendar(calendarId:Int, completion: @escaping (Bool) -> ())  {
        let token  = KeychainWrapper.standard.string(forKey: "token")
        if(token != nil){
            self.tron.headerBuilder = HeaderBuilder(defaultHeaders: ["Authorization": token!])
        }
        let request: APIRequest<JSON, JSONError> = tron.swiftyJSON.request("/calendar/\(calendarId)")
        request.method = .delete
        request.perform(withSuccess: { (calendar) in
            completion(true)
        }) { (err) in
            print("failed to fetch json...", err)
            completion(false)
        }

    }
    
    
}
