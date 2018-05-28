//
//  PriceNode.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

class PriceNode: ASDisplayNode {
    
    let priceTextNode = ASTextNode()
    
    init(price: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        priceTextNode.attributedText = price.makePriceAttributedString()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let backgroundPrice = ASDisplayNode()
        backgroundPrice.cornerRadius = 16
        backgroundPrice.borderColor = AppColors.price.cgColor
        backgroundPrice.borderWidth = 1.5
        
        let priceCenter = ASCenterLayoutSpec()
        priceCenter.centeringOptions = .XY
        priceCenter.child = priceTextNode
        
        let insets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        
        return ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: insets, child: priceCenter),
                                      background: backgroundPrice)
    }
}
