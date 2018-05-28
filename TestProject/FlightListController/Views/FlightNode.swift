//
//  FlightNode.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

class FlightNode: ASDisplayNode {
    
    let departurePlaceNode = ASTextNode()
    let arrivePlaceTextNode = ASTextNode()
    let separaterTextNode = ASTextNode()
    let dateTextNode = ASTextNode()
    let flightTimeTextNode = ASTextNode()

    let durationNode: DurationFlightNode
    
    let flight: FlightDetailsModel
    let layoverTime: String?
    
    init(flight: FlightDetailsModel, layoverTime: String?) {
        self.flight = flight
        self.layoverTime = layoverTime
        self.durationNode = DurationFlightNode(duration: flight.durationTimeString())
        
        super.init()
        automaticallyManagesSubnodes = true
        
        departurePlaceNode.attributedText = "\(flight.from.id), \(flight.from.city)".makeAttributedPlaceString()
        arrivePlaceTextNode.attributedText = "\(flight.to.id), \(flight.to.city)".makeAttributedPlaceString()
        separaterTextNode.attributedText = "⎯⎯".makeAttributedString()
        
        dateTextNode.attributedText = flight.departureDateString().makePlainAttributedString()
        flightTimeTextNode.attributedText = flight.flightTimeString().makePlainAttributedString()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 8
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.children = [departurePlaceNode, separaterTextNode, arrivePlaceTextNode]
        horizontalStack.alignContent = .start
        horizontalStack.spacing = 4
        
        verticalStack.children?.append(horizontalStack)
        verticalStack.children?.append(dateTextNode)

        // MARK: - Duration

        let flightTimeCenter = ASCenterLayoutSpec()
        flightTimeCenter.child = flightTimeTextNode
        flightTimeCenter.centeringOptions = .Y
        
        let horizontalTimeFlightStack = ASStackLayoutSpec.horizontal()
        horizontalTimeFlightStack.spacing = 6
        horizontalTimeFlightStack.children = [flightTimeCenter, durationNode]
        
        verticalStack.children?.append(horizontalTimeFlightStack)
        
        // MARK: - Options
        
        for option in flight.options {
            let optionNode = FlightOptionNode(icon: UIImage(named: "icon"), title: option)
            verticalStack.children?.append(optionNode)
        }
        
        if let layoverTime = layoverTime {
            let layoverNode = LayoverNode(place: "\(flight.from.id), \(flight.from.city)", time: layoverTime)
            verticalStack.children?.append(layoverNode)
        }

        return verticalStack
    }
}

