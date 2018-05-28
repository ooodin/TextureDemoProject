//
//  AirportModel.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import Foundation

struct AirportModel {
    let id: String
    let city: String
}

extension AirportModel: Equatable, Hashable {
    
    public var hashValue: Int {
        return id.hashValue
    }
    
    public static func == (lhs: AirportModel, rhs: AirportModel) -> Bool {
        return lhs.id == rhs.id
    }
}
