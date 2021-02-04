//
//  ExString.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation

extension String {
    
    func getHourFromDate() -> String {
        
        let mDateF = DateFormatter()
        mDateF.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        mDateF.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        guard let dateIn = mDateF.date(from: self) else { return "" }
        
        mDateF.dateFormat = "h:mm a"
        mDateF.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return mDateF.string(from: dateIn)
    }
}
