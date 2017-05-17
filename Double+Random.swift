//
//  Double+Random.swift
//  Swift+Extensions
//
//  Created by iKing on 17.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import Foundation

extension Double {
	
	static func random(_ max: Double) -> Double {
		return random(min: 0, max: max)
	}
	
	static func random(min: Double, max: Double) -> Double {
		return Double(arc4random()) / Double(UINT32_MAX) * Swift.abs(max - min) + (min < max ? min : max)
	}
}
