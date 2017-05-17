//
//  Array+SafeSubscript.swift
//  Swift+Extensions
//
//  Created by iKing on 17.05.17.
//  Copyright © 2017 iKing. All rights reserved.
//

import Foundation

extension Array {
	
	subscript(safe index: Index?) -> Element? {
		guard let index = index, index >= 0, index < count else {
			return nil
		}
		return self[index]
	}
}
