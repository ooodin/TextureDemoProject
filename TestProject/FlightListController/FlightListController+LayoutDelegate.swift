//
//  FlightListController+LayoutDelegate.swift
//  TestProject
//
//  Created by Artem Semavin on 26/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

extension FlightListController: ASCollectionDelegateFlowLayout {

    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let insets = collectionNode.contentInset
        let width = UIScreen.main.bounds.width - (insets.left + insets.right)
        let minSize = CGSize(width: width, height: 120)
        
        if indexPath == selectionIndex {
            let maxSize = CGSize(width: width, height: 1000)
            return ASSizeRange(min: minSize, max: maxSize)
        } else {
            let maxSize = CGSize(width: width, height: 200)
            return ASSizeRange(min: minSize, max: maxSize)
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        let insets = collectionNode.contentInset
        let width = UIScreen.main.bounds.width - (insets.left + insets.right)
        
        let sectionSize = CGSize(width: width, height: 50)
        return ASSizeRange(min: sectionSize, max: sectionSize)
    }
    
}
