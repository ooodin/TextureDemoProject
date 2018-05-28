//
//  FlightOptionNode.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

class FlightOptionNode: ASDisplayNode {
    
    let optionTextNode = ASTextNode()
    
    let iconNode: ASImageNode = {
        let iconNode = ASImageNode()
        iconNode.contentMode = .scaleAspectFit
        iconNode.style.preferredSize = CGSize(width: 16, height: 16)
        
        return iconNode
    }()
    
    init(icon: UIImage?, title: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        iconNode.image = icon
        optionTextNode.attributedText = title.makePlainAttributedString()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASCommonSpecs.iconTextVerticalCenterBlock(icon: iconNode, text: optionTextNode)
    }
}
