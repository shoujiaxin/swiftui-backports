//
//  Backport+Geometry.swift
//  SwiftUIBackports
//
//  Created by Jiaxin Shou on 2024/10/26.
//

import SwiftUI

public extension Backport where Value: View {
    @available(iOS, introduced: 15.0)
    @MainActor
    func onGeometryChange<T>(
        for _: T.Type,
        of transform: @escaping (GeometryProxy) -> T,
        action: @escaping (_ newValue: T) -> Void
    ) -> some View where T: Equatable {
        wrappedValue
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .backport
                        .onChange(of: transform(geometry), initial: true) {
                            action($1)
                        }
                }
            }
    }

    @available(iOS, introduced: 15.0)
    @MainActor
    func onGeometryChange<T>(
        for _: T.Type,
        of transform: @escaping (GeometryProxy) -> T,
        action: @escaping (_ oldValue: T, _ newValue: T) -> Void
    ) -> some View where T: Equatable {
        wrappedValue
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .backport
                        .onChange(of: transform(geometry), initial: true, action)
                }
            }
    }
}
