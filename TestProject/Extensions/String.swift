//
//  String.swift
//  TestProject
//
//  Created by Artem Semavin on 28/05/2018.
//  Copyright © 2018 ooodin. All rights reserved.
//

import UIKit

extension String {
    
    func makeLayoverPlaceAttributedText() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular),
            NSAttributedStringKey.foregroundColor: AppColors.darkFont
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeLayoverTimeAttributedString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular),
            NSAttributedStringKey.foregroundColor: AppColors.labelBackground
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makePlainAttributedString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular),
            NSAttributedStringKey.foregroundColor: AppColors.darkFont
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeTotalDurationAttributedString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold),
            NSAttributedStringKey.foregroundColor: AppColors.darkFont
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeTotalDurationTitleAttributedString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular),
            NSAttributedStringKey.foregroundColor: AppColors.labelBackground
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makePriceAttributedString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular),
            NSAttributedStringKey.foregroundColor: AppColors.price
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeCompanyNameAttributedString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular),
            NSAttributedStringKey.foregroundColor: AppColors.darkFont
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeAttributedString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold),
            NSAttributedStringKey.foregroundColor: AppColors.darkFont
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeAttributedDurationString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeAttributedRatingString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold),
            NSAttributedStringKey.foregroundColor: AppColors.labelBackground
        ]
        
        return NSAttributedString(string: self, attributes: textAttributes)
    }
    
    func makeAttributedDateString() -> NSAttributedString {
        
        let textAttributesExtra: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)
        ]
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold),
            NSAttributedStringKey.foregroundColor: AppColors.darkFont
        ]
        
        let attrString = NSMutableAttributedString(string: self, attributes: textAttributes)
        
        let range = NSMakeRange(count - 2, 2)
        attrString.addAttributes(textAttributesExtra, range: range)
        
        return attrString
    }
    
    func makeAttributedPlaceString() -> NSAttributedString {
        
        let textAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold),
            NSAttributedStringKey.foregroundColor: AppColors.darkFont
        ]
    
        return NSAttributedString(string: self, attributes: textAttributes)
    }
}
