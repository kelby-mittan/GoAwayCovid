//
//  String.swift
//  CovidGoAway
//
//  Created by Kelby Mittan on 12/14/20.
//

import UIKit

extension String {
    func emojiToImage() -> UIImage? {
        let size = CGSize(width: 50, height: 55)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(rect)
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
