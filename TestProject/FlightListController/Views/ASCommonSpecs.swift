//
//  ASCommonSpecs.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

struct ASCommonSpecs {
    
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
