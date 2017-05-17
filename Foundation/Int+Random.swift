//
//  Int+Random.swift
//  Swift+Extensions
//
//  Created by iKing on 17.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import Foundation

extension Int {
	
	static func random(_ max: Int) -> Int {
		return random(min: 0, max: max)
	}
	
	static func random(min: Int, max: Int) -> Int {
		return Int(arc4random_uniform(UInt32(abs(max - min))) + UInt32(min < max ? min : max))
	}
}
