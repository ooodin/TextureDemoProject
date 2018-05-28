//
//  FlightCell.swift
//  TestProject
//
//  Created by Artem Semavin on 26/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import AsyncDisplayKit

final class FlightNodeCell: ASCellNode {

    let openActionBlock: (()->Void)?
    let model: FlightInfoModel
    
    let openButton = ASButtonNode()
    
    let departureDate = ASTextNode()
    let separaterDate = ASTextNode()
    let arrivalDate = ASTextNode()
    let companyNameNode = ASTextNode()
    let ratingNode = ASTextNode()
    
    let ratingIcon: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.contentMode = .scaleAspectFit
        imageNode.style.height = ASDimension(unit: .points, value: 13)
        return imageNode
    }()
    
    let companyIcon: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.contentMode = .scaleAspectFit
        imageNode.style.preferredSize = CGSize(width: 24, height: 24)
        return imageNode
    }()
    
    init(flightModel: FlightInfoModel, openAction: (()->Void)?) {
        self.openActionBlock = openAction
        self.model = flightModel
        
        super.init()
        setupUI()
        
        self.backgroundColor = .white
        self.cornerRadius = 6
        self.borderWidth = 1
        self.borderColor = AppColors.border.cgColor
        self.automaticallyManagesSubnodes = true
    }
    
    private func setupUI() {
    
        self.ratingIcon.image = UIImage(named: "clouds")
        self.companyIcon.image = UIImage(named: "icon")
        
        self.openButton.setImage(UIImage(named: "arrow_down"), for: .normal)
        self.openButton.setImage(UIImage(named: "arrow_down"), for: .highlighted)
        self.openButton.addTarget(self, action: #selector(openAction), forControlEvents: .touchUpInside)
        
        self.companyNameNode.attributedText = model.company.makeCompanyNameAttributedString()
        self.departureDate.attributedText = model.departureDateString().makeAttributedDateString()
        self.arrivalDate.attributedText   = model.arrivalDateString().makeAttributedDateString()
        self.separaterDate.attributedText = "⎯⎯".makeAttributedString()
        self.ratingNode.attributedText = model.rating.makeAttributedRatingString()
    }
    
    @objc func openAction() {
        openActionBlock?()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let headerBlock = layoutHeaderSpec(constrainedSize)
        let footerBlock = layoutFooterSpec(constrainedSize)
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [headerBlock, spacer, footerBlock]
        
        let insets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return ASInsetLayoutSpec(insets: insets, child: verticalStack)
    }
    
    private func layoutHeaderSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let durationNode = DurationFlightNode(duration: model.duration)

        let spacer = ASLayoutSpec()
        spacer.style.width = ASDimension(unit: .auto, value: 12)
        
        let buttonSpacer = ASLayoutSpec()
        buttonSpacer.style.flexGrow = 1.0
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.alignContent = .start
        horizontalStack.spacing = 4
        horizontalStack.children = [departureDate, separaterDate, arrivalDate,
                                    spacer, durationNode, buttonSpacer, openButton]
        return horizontalStack
    }
    
    private func layoutFooterSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
        let price = PriceNode(price: model.price)
        let company = ASCommonSpecs.iconTextVerticalCenterBlock(icon: companyIcon, text: companyNameNode)
        let rating = ASCommonSpecs.iconTextVerticalCenterBlock(icon: ratingIcon, text: ratingNode)
        
        let spacerRatingPrice = ASLayoutSpec()
        spacerRatingPrice.style.width = ASDimension(unit: .points, value: 10)
        
        let ratingPriceBlock = ASStackLayoutSpec.horizontal()
        ratingPriceBlock.children = [rating, spacerRatingPrice, price]
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
     
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.alignContent = .start
        horizontalStack.children = [company, spacer, ratingPriceBlock]
        
        return horizontalStack
    }
}
