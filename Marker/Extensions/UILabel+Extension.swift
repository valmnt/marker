//
//  UILabel+Extension.swift
//  Marker
//
//  Created by Valentin Mont on 13/09/2024.
//

import Foundation
import UIKit

extension UILabel {
    func addTrailing(image: UIImage, text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: text, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
}
