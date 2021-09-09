//
//  adjustFontSizeToFillRectProtocol.swift
//  face-app
//
//  Created by Aliona Kostenko on 09.07.2021.
//

import Foundation
import UIKit

protocol adjustFontSizeToFillRectProtocol {
    func adjustFontSizeToFillRect(_ newBounds: CGRect, view: FloatingViewContainer) -> Void
    func adjustsWidthToFillItsContents(_ view: FloatingViewContainer) -> Void
}

extension adjustFontSizeToFillRectProtocol {
    
    func adjustFontSizeToFillRect(_ newBounds: CGRect, view: FloatingViewContainer) {
        guard let labelTextView = view.labelTextView else {
            return
        }
        var mid: CGFloat = 0.0
        var stickerMaximumFontSize: CGFloat = 200.0
        var stickerMinimumFontSize: CGFloat = 11.0
        var difference: CGFloat = 0.0

        var tempFont = UIFont(name: labelTextView.fontName, size: labelTextView.fontSize)
        var copyTextAttributes = labelTextView.textAttributes
        copyTextAttributes[.font] = tempFont
        var attributedText = NSAttributedString(string: labelTextView.text, attributes: copyTextAttributes)

        while stickerMinimumFontSize <= stickerMaximumFontSize {
            mid = stickerMinimumFontSize + (stickerMaximumFontSize - stickerMinimumFontSize) / 2.0
            tempFont = UIFont(name: labelTextView.fontName, size: CGFloat(mid))!
            copyTextAttributes[.font] = tempFont
            attributedText = NSAttributedString(string: labelTextView.text, attributes: copyTextAttributes)
            let height = attributedText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                     options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height
            difference = newBounds.height - height
            if (mid == stickerMinimumFontSize || mid == stickerMaximumFontSize) {
                if (difference < 0) {
                    view.fontSize = mid - 1.0
                    return
                }

                view.fontSize = mid
                return
            }

            if (difference < 0) {
                stickerMaximumFontSize = mid - 0.1
            } else if (difference > 0) {
                stickerMinimumFontSize = mid + 0.1
            } else {
                view.fontSize = mid
                return
            }
        }
        view.fontSize = mid
    }
    
    func adjustsWidthToFillItsContents(_ view: FloatingViewContainer) {
        guard let labelTextView = view.labelTextView else { return }
        let attributedText = labelTextView.attributedText
        let textInsets = labelTextView.textContainerInset
        guard let recSize = attributedText?.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                         options: [.usesLineFragmentOrigin], context: nil) else { return }
        let w1 = ceil(recSize.size.width)
        let h1 = ceil(recSize.size.height)
        let insets = UIEdgeInsets(top: -32, left: -32, bottom: -32, right: -32)

        let fontDescender = labelTextView.font?.descender ?? .zero
        var viewFrame = view.bounds
        viewFrame.size.width = w1 + textInsets.left + textInsets.right - (insets.left + insets.right)
        viewFrame.size.height = h1 + textInsets.top + textInsets.bottom - (insets.bottom + insets.top + fontDescender)
        view.bounds.size = viewFrame.size
        view.containerForControls?.frame.size = viewFrame.size
        labelTextView.frame.size = CGSize(width: w1 + textInsets.left + textInsets.right,
                                          height: h1 + textInsets.top + textInsets.bottom - fontDescender)
        labelTextView.frame.origin = CGPoint(x: 32, y: 32)
    }
}
