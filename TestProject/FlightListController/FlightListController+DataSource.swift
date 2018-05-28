//
//  FlightListController+DataSource.swift
//  TestProject
//
//  Created by Artem Semavin on 26/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

extension FlightListController: ASCollectionDataSource {
 
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return flightListData.numberOfSections
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return flightListData.numberOfFlightsInSection(section)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        
        let flightModel = flightListData.flightForItemAtIndexPath(indexPath)
        
        let closeActionBlock = { [weak self] in
            self?.selectionIndex = nil
            self?.node.performBatch(animated: true, updates: {
                self?.node.reloadItems(at: [indexPath])
            }, completion: nil)
        }
        
        let openActionBlock = { [weak self] in
            let previousIndex = self?.selectionIndex
            self?.selectionIndex = indexPath
            
            self?.node.performBatch(animated: true, updates: {
                var updateIndexes = [indexPath]
                if let index = previousIndex {
                    updateIndexes.append(index)
                }
                self?.node.reloadItems(at: updateIndexes)
            }, completion: nil)
        }
        
        if selectionIndex == indexPath {
            return FlightDetailNodeCell(flightModel: flightModel, openAction: closeActionBlock)
        } else {
            return FlightNodeCell(flightModel: flightModel, openAction: openActionBlock)
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        let title = flightListData.titleForSectionAtIndexPath(indexPath)
        return FlightSectionCellNode(title: title)
    }
}
