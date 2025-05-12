//
//  WithConfigurable.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation

public protocol WithConfigurable {}
public extension WithConfigurable where Self: AnyObject {
    @discardableResult
    func with(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: WithConfigurable {}
