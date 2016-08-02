//
//  Extensions.swift
//  Music
//
//  Created by Devin Roth on 7/23/16.
//  Copyright © 2016 Devin Roth Music. All rights reserved.
//

import Foundation

extension Array {
    public func rotate(_ index: Int) -> Array<Element>? {
        if index > self.count { return nil }
        var array = self[index..<self.count]
        array += self[0..<index]
        return Array(array)
    }
}
