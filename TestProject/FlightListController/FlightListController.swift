//
//  ViewController.swift
//  TestProject
//
//  Created by Artem Semavin on 26/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

class FlightListController: ASViewController<ASCollectionNode> {

    private(set) var flightListData: FlightListModel
    var selectionIndex: IndexPath?
    
    init() {
        self.flightListData = FlightListModel()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        
        super.init(node: collectionNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private func setupUI() {
        
        node.dataSource = self
        node.delegate = self
        node.allowsSelection = false
        node.leadingScreensForBatching = 2.5
        node.registerSupplementaryNode(ofKind: UICollectionElementKindSectionHeader)
        
        node.contentInset = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
        node.backgroundColor = AppColors.background
        
        navigationItem.title = "Flight list"
        navigationController?.hidesBarsOnSwipe = true
    }
}

