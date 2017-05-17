//
//  UIImage+Insets.swift
//  Swift+Extensions
//
//  Created by iKing on 17.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import UIKit

extension UIImage {
	
	/**
	Produces new image from existing by adding specified `insets`.
	
	- parameter insets: Desire imge insets.
	
	- returns: New image with insets.
	*/
	func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(
			CGSize(width: self.size.width + insets.left + insets.right,
			       height: self.size.height + insets.top + insets.bottom), false, self.scale)
		let origin = CGPoint(x: insets.left, y: insets.top)
		self.draw(at: origin)
		let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return imageWithInsets
	}
}
