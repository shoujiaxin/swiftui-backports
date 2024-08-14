//
//  Backport+Toolbars.swift
//  SwiftUIBackports
//
//  Created by Jiaxin Shou on 2024/8/13.
//

import SwiftUI

public extension Backport where Value: View {
    @available(iOS, introduced: 16.0, deprecated: 18.0)
    @ViewBuilder
    func toolbarVisibility(_ visibility: Visibility, for bar: ToolbarPlacement) -> some View {
        if #available(iOS 18.0, *) {
            wrappedValue
                .toolbarVisibility(visibility, for: bar)
        } else {
            wrappedValue
                .toolbar(visibility, for: bar)
        }
    }
}
