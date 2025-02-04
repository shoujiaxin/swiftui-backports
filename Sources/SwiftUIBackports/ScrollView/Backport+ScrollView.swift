//
//  Backport+ScrollView.swift
//  SwiftUIBackports
//
//  Created by Jiaxin Shou on 2024/8/13.
//

import SwiftUI

public extension Backport where Value: View {
    @available(iOS, introduced: 14.0, deprecated: 18.0)
    @MainActor
    @ViewBuilder
    func onScrollGeometryChange<T>(
        for type: T.Type,
        of transform: @escaping (ScrollGeometry) -> T,
        action: @escaping (_ oldValue: T, _ newValue: T) -> Void
    ) -> some View where T: Equatable {
        if #available(iOS 18.0, *) {
            wrappedValue
                .onScrollGeometryChange(
                    for: type,
                    of: {
                        transform(
                            .init(
                                contentOffset: $0.contentOffset,
                                contentSize: $0.contentSize,
                                contentInsets: $0.contentInsets,
                                containerSize: $0.containerSize
                            )
                        )
                    },
                    action: action
                )
        } else {
            wrappedValue
                .modifier(
                    ScrollGeometryObserver(
                        transform: transform,
                        action: action
                    )
                )
        }
    }
}
