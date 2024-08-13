//
//  Backport.swift
//  SwiftUIBackports
//
//  Created by Jiaxin Shou on 2024/8/13.
//

import SwiftUI

public struct Backport<Value> {
    let wrappedValue: Value
}

public extension View {
    var backport: Backport<Self> {
        .init(wrappedValue: self)
    }
}
