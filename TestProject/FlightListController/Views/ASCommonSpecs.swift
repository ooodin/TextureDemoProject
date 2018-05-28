//
//  ASCommonSpecs.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

struct ASCommonSpecs {

    static func makePriceLayoutSpec(price: String) -> ASLayoutSpec {
        
        let backgroundPrice = ASDisplayNode()
        backgroundPrice.cornerRadius = 16
        backgroundPrice.borderColor = AppColors.price.cgColor
        backgroundPrice.borderWidth = 1.5
        
        let priceText = ASTextNode()
        priceText.attributedText = price.makePriceAttributedString()
        
        let priceCenter = ASCenterLayoutSpec()
        priceCenter.centeringOptions = .XY
        priceCenter.child = priceText

        let insets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)

        return ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: insets, child: priceCenter),
                                      background: backgroundPrice)
    }
    
    static func makeDurationFlightSpec(duration: String) -> ASLayoutSpec {
        
        let durationIcon = ASImageNode()
        durationIcon.contentMode = .scaleAspectFit
        durationIcon.style.preferredSize = CGSize(width: 13, height: 13)
        durationIcon.image = UIImage(named: "clock")
        
        let durationText = ASTextNode()
        durationText.attributedText = duration.makeAttributedDurationString()
        
        let durationStack = ASCommonSpecs.iconTextVerticalCenterBlock(icon: durationIcon, text: durationText)
        
        let insets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        let durationStackWithInsets = ASInsetLayoutSpec(insets: insets, child: durationStack)
        
        let backgroundNode = ASDisplayNode()
        backgroundNode.backgroundColor = AppColors.labelBackground
        backgroundNode.cornerRadius = 4
        
        return ASBackgroundLayoutSpec(child: durationStackWithInsets,
                                      background: backgroundNode)
    }
    
    static func iconTextVerticalCenterBlock(icon: ASImageNode, text: ASTextNode) -> ASLayoutSpec {
        
        let iconCenter = ASCenterLayoutSpec()
        iconCenter.centeringOptions = .XY
        iconCenter.child = icon
        
        let textCenter = ASCenterLayoutSpec()
        textCenter.centeringOptions = .Y
        textCenter.child = text
        
        let horizontalBlock = ASStackLayoutSpec.horizontal()
        horizontalBlock.spacing = 4
        horizontalBlock.children = [iconCenter, textCenter]
        
        return horizontalBlock
    }
}
