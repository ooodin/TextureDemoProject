//
//  DurationFlightNode.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

class DurationFlightNode: ASDisplayNode {
    
    let durationTextNode = ASTextNode()
    
    let durationIconNode: ASImageNode = {
        let icon = ASImageNode()
        icon.contentMode = .scaleAspectFit
        icon.style.preferredSize = CGSize(width: 13, height: 13)
        icon.image = UIImage(named: "clock")
        return icon
    }()
    
    init(duration: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        durationTextNode.attributedText = duration.makeAttributedDurationString()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let durationStack = ASCommonSpecs.iconTextVerticalCenterBlock(icon: durationIconNode, text: durationTextNode)
        
        let insets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        let durationStackWithInsets = ASInsetLayoutSpec(insets: insets, child: durationStack)
        
        let backgroundNode = ASDisplayNode()
        backgroundNode.backgroundColor = AppColors.labelBackground
        backgroundNode.cornerRadius = 4
        
        return ASBackgroundLayoutSpec(child: durationStackWithInsets,
                                      background: backgroundNode)
    }
}
