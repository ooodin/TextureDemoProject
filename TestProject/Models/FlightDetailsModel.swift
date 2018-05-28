//
//  FlightDetailsModel.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import Foundation

struct FlightDetailsModel {
    
    let from: AirportModel
    let to: AirportModel
    
    let departureDate: Date
    let arrivalDate: Date
    let price: Double
    
    let company: String
    let options: [String]
    
    func departureDateString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d MMMM YYYY"
        return "\(dateFormater.string(from: departureDate)) г."
    }
    
    func flightTimeString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "H:mm"
        
        return "\(dateFormater.string(from: departureDate)) ⎯⎯ \(dateFormater.string(from: arrivalDate))"
    }
    
    func durationTimeString() -> String {
        
        let timeDifference = Calendar.current
            .dateComponents([.hour, .minute], from: departureDate, to: arrivalDate)
        let hours = timeDifference.hour == nil ? "" : " \(timeDifference.hour ?? 0) ч"
        let minutes = timeDifference.minute == nil ? " 00" : " \(timeDifference.minute ?? 0)"
        
        return "\(hours)\(minutes) мин"
    }
}
