//
//  String+Extensions.swift
//  Messages
//
//  Created by ozan honamlioglu on 10.07.2021.
//

import UIKit

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)
        return size.width
    }
    
}
