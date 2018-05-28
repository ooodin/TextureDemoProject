//
//  FlightSectionCellNode.swift
//  TestProject
//
//  Created by Artem Semavin on 27/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

final class FlightSectionCellNode: ASTextCellNode {
    
    init(title: String) {
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let textAttributes : [AnyHashable: Any] = [
            kCTFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold),
            kCTForegroundColorAttributeName: AppColors.darkFont.cgColor
        ]
        
        super.init(attributes: textAttributes, insets: insets)
        self.text = title
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let centerLayout = ASCenterLayoutSpec()
        centerLayout.centeringOptions = .Y
        centerLayout.child = self.textNode
        return centerLayout
    }
}
