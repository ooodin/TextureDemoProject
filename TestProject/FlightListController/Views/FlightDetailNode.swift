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
            let flightNode = FlightNode(flight: flight, layoverTime: model.layoverTime[flight.to])
            verticalStack.children?.append(flightNode)
        }

        return verticalStack
    }
    
    private func layoutFooterSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let totalDuration = layoutTotalDurationSpec()
        let priceNode = PriceNode(price: model.price)

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
