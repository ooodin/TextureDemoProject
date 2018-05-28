//
//  FlightDetailNode.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//


import AsyncDisplayKit

final class FlightDetailNodeCell: ASCellNode {
    
    let openActionBlock: (()->Void)?
    let model: FlightInfoModel
    
    let openButton = ASButtonNode()
    let totalDurationTitleNode = ASTextNode()
    let totalDurationNode = ASTextNode()
    
    init(flightModel: FlightInfoModel, openAction: (()->Void)?) {
        self.openActionBlock = openAction
        self.model = flightModel
        
        super.init()
        setupUI()
        
        self.backgroundColor = .white
        self.cornerRadius = 6
        self.borderWidth = 1
        self.borderColor = AppColors.border.cgColor
        self.automaticallyManagesSubnodes = true
    }
    
    private func setupUI() {
        
        self.openButton.setImage(UIImage(named: "arrow_up"), for: .normal)
        self.openButton.setImage(UIImage(named: "arrow_up"), for: .highlighted)
        self.openButton.addTarget(self, action: #selector(openAction), forControlEvents: .touchUpInside)
        
        self.totalDurationTitleNode.attributedText = "Total duration".makeTotalDurationTitleAttributedString()
        self.totalDurationNode.attributedText = model.duration.makeTotalDurationAttributedString()
    }
    
    @objc func openAction() {
        openActionBlock?()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let flightsBlock = layoutFlightListSpec(constrainedSize)
        let footerBlock = layoutFooterSpec(constrainedSize)
        
        let spacer = ASLayoutSpec()
        spacer.style.height = ASDimension(unit: .points, value: 20)
        
        let insets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
        let openRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: .end, verticalPosition: .start,
                                                sizingOption: [], child: openButton)
        let openInsets = ASInsetLayoutSpec(insets: insets, child: openRelativeSpec)
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [flightsBlock, spacer, footerBlock]
        
        let verticalStackInsets = ASInsetLayoutSpec(insets: insets, child: verticalStack)
        return ASOverlayLayoutSpec(child: verticalStackInsets, overlay: openInsets)
    }
    
    private func layoutFlightListSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignContent = .start
        verticalStack.spacing = 10
        
        for flight in model.direction {
            let flightSpec = layoutFlightSpec(constrainedSize, flight: flight)
            verticalStack.children?.append(contentsOf: flightSpec)
        }

        return verticalStack
    }
    
    private func layoutFooterSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let totalDuration = layoutTotalDurationSpec()
        let priceNode = ASCommonSpecs.makePriceLayoutSpec(price: model.price)

        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.alignContent = .start
        horizontalStack.children = [totalDuration, spacer, priceNode]
        
        return horizontalStack
    }
    
    private func layoutTotalDurationSpec() -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignContent = .start
        verticalStack.alignItems = .start
        
        verticalStack.children = [totalDurationTitleNode, totalDurationNode]
        return verticalStack
    }
}

// MARK: - FLights block

extension FlightDetailNodeCell {
    
    private func layoutFlightSpec(_ constrainedSize: ASSizeRange, flight: FlightDetailsModel) -> [ASLayoutElement] {
        
        var stack: [ASLayoutElement] = []

        // MARK: - Places
        
        let depPalce = ASTextNode()
        depPalce.attributedText = "\(flight.from.id), \(flight.from.city)".makeAttributedPlaceString()
        
        let arrPalce = ASTextNode()
        arrPalce.attributedText = "\(flight.to.id), \(flight.to.city)".makeAttributedPlaceString()
        
        let separater = ASTextNode()
        separater.attributedText = "⎯⎯".makeAttributedString()
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.children = [depPalce, separater, arrPalce]
        horizontalStack.alignContent = .start
        horizontalStack.spacing = 4
        
        stack.append(horizontalStack)
        
        // MARK: - Date
        
        let dateTextNode = ASTextNode()
        dateTextNode.attributedText = flight.departureDateString().makePlainAttributedString()
        
        stack.append(dateTextNode)
        
        // MARK: - Duration
        
        let flightTimeTextNode = ASTextNode()
        flightTimeTextNode.attributedText = flight.flightTimeString().makePlainAttributedString()
        
        let flightTimeCenter = ASCenterLayoutSpec()
        flightTimeCenter.child = flightTimeTextNode
        flightTimeCenter.centeringOptions = .Y
        
        let durationNode = ASCommonSpecs.makeDurationFlightSpec(duration: model.duration)
        
        let horizontalTimeFlightStack = ASStackLayoutSpec.horizontal()
        horizontalTimeFlightStack.spacing = 6
        horizontalTimeFlightStack.children = [flightTimeCenter, durationNode]
        
        stack.append(horizontalTimeFlightStack)
        
        // MARK: - Options
        
        for option in flight.options {
            
            let iconNode = ASImageNode()
            iconNode.contentMode = .scaleAspectFit
            iconNode.style.preferredSize = CGSize(width: 16, height: 16)
            iconNode.image = UIImage(named: "icon")
            
            let optionTextNode = ASTextNode()
            optionTextNode.attributedText = option.makePlainAttributedString()
            
            let optionCenter = ASCenterLayoutSpec()
            optionCenter.child = flightTimeTextNode
            optionCenter.centeringOptions = .Y
            
            let optionNode = ASCommonSpecs.iconTextVerticalCenterBlock(icon: iconNode, text: optionTextNode)
            stack.append(optionNode)
        }
        
        if let layoverTime = model.layoverTime[flight.to] {
            
            let spacer = ASLayoutSpec()
            spacer.style.height = ASDimension(unit: .points, value: 14)
            
            stack.append(spacer)
            
            let layoverPalceText = ASTextNode()
            layoverPalceText.attributedText = "\(flight.to.id), \(flight.to.city)".makeLayoverPlaceAttributedText()
            
            let layoverTimeText = ASTextNode()
            layoverTimeText.attributedText = layoverTime.makeLayoverTimeAttributedString()
            
            let layoverStack = ASStackLayoutSpec.vertical()
            layoverStack.alignContent = .center
            layoverStack.spacing = 4
            
            let centerPlaceText = ASCenterLayoutSpec()
            centerPlaceText.centeringOptions = .XY
            centerPlaceText.child = layoverPalceText
            
            let centerTimeText = ASCenterLayoutSpec()
            centerTimeText.centeringOptions = .XY
            centerTimeText.child = layoverTimeText
            
            layoverStack.children = [centerPlaceText, centerTimeText]
            
            stack.append(layoverStack)
        }
        
        let spacer = ASLayoutSpec()
        spacer.style.height = ASDimension(unit: .points, value: 14)
        
        stack.append(spacer)
        
        return stack
    }
    
}










