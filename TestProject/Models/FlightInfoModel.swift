//
//  FlightModel.swift
//  TestProject
//
//  Created by Artem Semavin on 26/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import Foundation
import UIKit

struct FlightInfoModel {
    
    let section: FlightListSections
    let departureDate: Date
    let arrivalDate: Date
    let price: String
    
    let company: String
    let rating: String
    let duration: String
    
    let direction: [FlightDetailsModel]
    let layoverTime: [AirportModel: String]
    
    init(section: FlightListSections, company: String, rating: String, direction: [FlightDetailsModel]) {
        self.section = section
        self.company = company
        self.rating = rating
        
        self.direction = direction.sorted(by: { (flight1, flight2) -> Bool in
            flight1.departureDate < flight2.departureDate
        })
        
        self.departureDate = direction.first!.departureDate
        self.arrivalDate = direction.last!.arrivalDate
        
        let priceSum = direction.reduce(0, { $0 + $1.price })
        self.price = String.localizedStringWithFormat("$%.2f", priceSum)
        
        // MARK: - Layover
        
        var lastFlight: FlightDetailsModel? = nil
        var layover: [AirportModel: String] = [:]
        
        for flight in self.direction {
            if let lastFlight = lastFlight {
                let timeDifference = Calendar.current
                    .dateComponents([.hour, .minute], from: lastFlight.arrivalDate, to: flight.departureDate)
                
                let hours = timeDifference.hour == nil ? "" : " \(timeDifference.hour ?? 0) ч"
                let minutes = timeDifference.minute == nil ? " 00" : " \(timeDifference.minute ?? 0)"
                
                layover[lastFlight.to] = "Layover\(hours)\(minutes) мин"
            }
            
            lastFlight = flight
        }
        
        self.layoverTime = layover
        
        // MARK: - Duration time
        
        let timeDifference = Calendar.current
            .dateComponents([.hour, .minute], from: departureDate, to: arrivalDate)
        let hours = timeDifference.hour == nil ? "" : " \(timeDifference.hour ?? 0) ч"
        let minutes = timeDifference.minute == nil ? " 00" : " \(timeDifference.minute ?? 0)"
        
        self.duration = "\(hours)\(minutes) мин"
    }
}

extension FlightInfoModel {
    
    func departureDateString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        return dateFormater.string(from: departureDate)
    }
    
    func arrivalDateString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        return dateFormater.string(from: arrivalDate)
    }
}
