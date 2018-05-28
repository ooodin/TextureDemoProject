//
//  ListModel.swift
//  TestProject
//
//  Created by Artem Semavin on 26/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import Foundation

enum FlightListSections: String {
    case best = "Best match", other = "Other flights"
}

struct FlightListModel {
    
    let sections: [FlightListSections]
    let flights: [FlightInfoModel]

    var numberOfSections: Int {
        return sections.count
    }
    
    init() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD.MM.yy HH:mm:ss"
        
        let airport1 = AirportModel(id: "JFK", city: "New York")
        let airport2 = AirportModel(id: "CMN", city: "Casablanca")
        let airport3 = AirportModel(id: "DXB", city: "Dubai")
        let airport4 = AirportModel(id: "LAX", city: "Los Angeles")
        
        let options = ["Wi-Fi is not available",
                       "Power outlets",
                       "In-flight entertaiment is available",
                       "Average legroom (31 in)"]
        
        let flightDetails1 = FlightDetailsModel(from: airport1,
                                                to: airport2,
                                                departureDate: dateFormatter.date(from: "01.10.18 13:43:00")!,
                                                arrivalDate: dateFormatter.date(from: "01.10.18 16:00:00")!,
                                                price: 95,
                                                company: "Lufthansa",
                                                options: options)
        
        let flightDetails2 = FlightDetailsModel(from: airport2,
                                                to: airport3,
                                                departureDate: dateFormatter.date(from: "01.10.18 17:11:00")!,
                                                arrivalDate: dateFormatter.date(from: "01.10.18 18:10:00")!,
                                                price: 86,
                                                company: "Lufthansa",
                                                options: options)
        
        let flightDetails3 = FlightDetailsModel(from: airport3,
                                                to: airport4,
                                                departureDate: dateFormatter.date(from: "01.10.18 21:45:00")!,
                                                arrivalDate: dateFormatter.date(from: "01.10.18 23:54:00")!,
                                                price: 46,
                                                company: "Lufthansa",
                                                options: options)
        
        let flightDetails4 = FlightDetailsModel(from: airport4,
                                                to: airport1,
                                                departureDate: dateFormatter.date(from: "02.10.18 13:12:00")!,
                                                arrivalDate: dateFormatter.date(from: "02.10.18 17:40:00")!,
                                                price: 12,
                                                company: "Lufthansa",
                                                options: options)
        
        let flightDetails5 = FlightDetailsModel(from: airport4,
                                                to: airport2,
                                                departureDate: dateFormatter.date(from: "03.10.18 13:00:00")!,
                                                arrivalDate: dateFormatter.date(from: "03.10.18 16:00:00")!,
                                                price: 34,
                                                company: "Lufthansa",
                                                options: options)
        
        self.sections = [FlightListSections.best,
                         FlightListSections.other]
        
        self.flights = [FlightInfoModel(section: FlightListSections.best, company: "Lufthansa", rating: "98", direction: [flightDetails1, flightDetails2, flightDetails3]),
            FlightInfoModel(section: FlightListSections.best, company: "Lufthansa", rating: "97", direction: [flightDetails1, flightDetails3]),
            FlightInfoModel(section: FlightListSections.best, company: "Lufthansa", rating: "96", direction: [flightDetails2, flightDetails3]),
            FlightInfoModel(section: FlightListSections.other, company: "Lufthansa", rating: "58", direction: [flightDetails1, flightDetails2, flightDetails3]),
        FlightInfoModel(section: FlightListSections.other, company: "Lufthansa", rating: "34", direction: [flightDetails1, flightDetails2, flightDetails3]),
        FlightInfoModel(section: FlightListSections.other, company: "Lufthansa", rating: "33", direction: [flightDetails4, flightDetails5])]

    }
    
    func numberOfFlightsInSection(_ index: Int) -> Int {
        let flights = flightsForSection(index)
        return flights.count
    }
    
    func flightForItemAtIndexPath(_ indexPath: IndexPath) -> FlightInfoModel {
        if indexPath.section > 0 {
            let flights = flightsForSection(indexPath.section)
            return flights[indexPath.item]
        } else {
            return flights[indexPath.item]
        }
    }
    
    func titleForSectionAtIndexPath(_ indexPath: IndexPath) -> String {
        return sections[indexPath.section].rawValue
    }
    
    fileprivate func flightsForSection(_ index: Int) -> [FlightInfoModel] {
        let section = sections[index]
        let papersInSection = flights.filter { (flight: FlightInfoModel) -> Bool in
            return flight.section == section
        }
        return papersInSection
    }
}
