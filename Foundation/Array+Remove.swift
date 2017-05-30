//
//  Array+Remove.swift
//  Swift+Extensions
//
//  Created by iKing on 30.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
	
	mutating func remove(_ object: Element) {
		if let index = index(of: object) {
			remove(at: index)
		}
	}
}
