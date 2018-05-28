//
//  LayoverNode.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

class LayoverNode: ASDisplayNode {
    
    let layoverPlaceTextNode = ASTextNode()
    let layoverTimeTextNode = ASTextNode()
    
    init(place: String, time: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        layoverPlaceTextNode.attributedText = place.makeLayoverPlaceAttributedText()
        layoverTimeTextNode.attributedText = time.makeLayoverTimeAttributedString()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignContent = .center
        verticalStack.spacing = 4
        
        let centerPlaceText = ASCenterLayoutSpec()
        centerPlaceText.centeringOptions = .XY
        centerPlaceText.child = layoverPlaceTextNode
        
        let centerTimeText = ASCenterLayoutSpec()
        centerTimeText.centeringOptions = .XY
        centerTimeText.child = layoverTimeTextNode
        
        verticalStack.children = [centerPlaceText, centerTimeText]
        
        let insets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        return ASInsetLayoutSpec(insets: insets, child: verticalStack)
    }
}
