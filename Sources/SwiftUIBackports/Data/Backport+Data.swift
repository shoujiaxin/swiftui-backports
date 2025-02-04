//
//  Backport+Data.swift
//  SwiftUIBackports
//
//  Created by Jiaxin Shou on 2024/8/13.
//

import SwiftUI

public extension Backport where Value: View {
    @available(iOS, introduced: 14.0, deprecated: 17.0)
    @ViewBuilder
    func onChange(
        of value: some Equatable,
        initial: Bool = false,
        _ action: @escaping () -> Void
    ) -> some View {
        if #available(iOS 17.0, *) {
            wrappedValue
                .onChange(of: value, initial: initial, action)
        } else if initial {
            wrappedValue
                .onChange(of: value) { _ in
                    action()
                }
                .onAppear {
                    action()
                }
        } else {
            wrappedValue
                .onChange(of: value) { _ in
                    action()
                }
        }
    }

    @available(iOS, introduced: 14.0, deprecated: 17.0)
    @ViewBuilder
    func onChange<V>(
        of value: V,
        initial: Bool = false,
        _ action: @escaping (_ oldValue: V, _ newValue: V) -> Void
    ) -> some View where V: Equatable {
        if #available(iOS 17.0, *) {
            wrappedValue
                .onChange(of: value, initial: initial, action)
        } else if initial {
            wrappedValue
                .onChange(of: value) { newValue in
                    action(value, newValue)
                }
                .onAppear {
                    action(value, value)
                }
        } else {
            wrappedValue
                .onChange(of: value) { newValue in
                    action(value, newValue)
                }
        }
    }
}
