//
//  UIImage+Resize.swift
//  Swift+Extensions
//
//  Created by iKing on 17.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import UIKit

extension UIImage {
	
	struct ResizeOptions: OptionSet {
		let rawValue: Int
		
		static let scale        = ResizeOptions(rawValue: 1 << 0)
		static let aspectFit    = ResizeOptions(rawValue: 1 << 1)
		static let aspectFill   = ResizeOptions(rawValue: 1 << 2)
		static let center       = ResizeOptions(rawValue: 1 << 3)
		static let left         = ResizeOptions(rawValue: 1 << 4)
		static let top          = ResizeOptions(rawValue: 1 << 5)
		static let right        = ResizeOptions(rawValue: 1 << 6)
		static let bottom       = ResizeOptions(rawValue: 1 << 7)
	}
	
	/**
	Produces new image of specified `size` resized with specified `options` and `backgroundColor`.
	
	- parameter size: Desire image size.
	- parameter options: Resize options. Default `options` are `[.scale, .center]`.
	If `options` are ambiguous, then default `options` will be applied.
	- parameter backgroundColor: Background color for new image.
	
	- returns: Resized image.
	*/
	func resized(to size: CGSize, with options: ResizeOptions = [.scale, .center], background backgroundColor: UIColor? = nil) -> UIImage? {
		
		// Scale mode
		let imageSize: CGSize
		switch options {
		case let o where o.contains(.scale) || (o.contains(.aspectFit) && o.contains(.aspectFill)):
			imageSize = size
		case let o where o.contains(.aspectFit):
			let ratio = min(size.width / self.size.width, size.height / self.size.height)
			imageSize = CGSize(width: self.size.width * ratio, height: self.size.height * ratio)
		case let o where o.contains(.aspectFill):
			let ratio = max(size.width / self.size.width, size.height / self.size.height)
			imageSize = CGSize(width: self.size.width * ratio, height: self.size.height * ratio)
		default:
			imageSize = size
		}
		
		// X-alignment
		let x: CGFloat
		switch options {
		case let o where o.contains(.center) || (o.contains(.left) && o.contains(.right)):
			x = size.width / 2 - imageSize.width / 2
		case let o where o.contains(.left):
			x = 0
		case let o where o.contains(.right):
			x = size.width - imageSize.width
		default:
			x = size.width / 2 - imageSize.width / 2
		}
		
		// Y-alignment
		let y: CGFloat
		switch options {
		case let o where o.contains(.center) || (o.contains(.top) && o.contains(.bottom)):
			y = size.height / 2 - imageSize.height / 2
		case let o where o.contains(.top):
			y = 0
		case let o where o.contains(.bottom):
			y = size.height - imageSize.height
		default:
			y = size.height / 2 - imageSize.height / 2
		}
		
		let rect = CGRect(origin: CGPoint(x: x, y: y), size: imageSize)
		UIGraphicsBeginImageContext(size)
		if let color = backgroundColor?.cgColor {
			let context = UIGraphicsGetCurrentContext()
			context?.setFillColor(color)
			context?.fill(CGRect(origin: .zero, size: size))
		}
		self.draw(in: rect)
		let resized = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return resized
	}
	
	/**
	Asynchronously produces new image of specified `size` resized with specified `options` and `backgroundColor`.
	
	- parameter size: Desire image size
	- parameter options: Resize options. Default `options` are `[.scale, .center]`.
	If `options` are ambiguous, then default `options` will be applied.
	- parameter backgroundColor: Background color for new image.
	- parameter callback: Function which is called right after new image was rendered.
	*/
	func resized(to size: CGSize, with options: ResizeOptions = [.scale, .center], background backgroundColor: UIColor? = nil, callback: ((UIImage?) -> ())?) {
		DispatchQueue.global(qos: .default).async {
			let image = self.resized(to: size, with: options, background: backgroundColor)
			DispatchQueue.main.async {
				callback?(image)
			}
		}
	}
	
}
