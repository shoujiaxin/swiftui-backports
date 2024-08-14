//
//  ScrollGeometryObserver.swift
//  SwiftUIBackports
//
//  Created by Jiaxin Shou on 2024/8/13.
//

import Foundation
import SwiftUI
@_spi(Advanced) import SwiftUIIntrospect

@available(iOS, introduced: 14.0, deprecated: 18.0)
struct ScrollGeometryObserver<T>: ViewModifier where T: Equatable {
    let transform: (ScrollGeometry) -> T

    let action: (_ oldValue: T, _ newValue: T) -> Void

    private class Store {
        var contentOffsetToken: NSKeyValueObservation?

        var contentSizeToken: NSKeyValueObservation?

        var contentInsetsToken: NSKeyValueObservation?

        var boundsToken: NSKeyValueObservation?
    }

    private let store: Store = .init()

    @State
    private var geometry: ScrollGeometry = .init(
        contentOffset: .zero,
        contentSize: .zero,
        contentInsets: .init(top: 0, leading: 0, bottom: 0, trailing: 0),
        containerSize: .zero
    )

    func body(content: Content) -> some View {
        content
            .introspect(.scrollView, on: .iOS(.v17...)) { scrollView in
                let options: NSKeyValueObservingOptions = [.initial, .new]

                store.contentOffsetToken?.invalidate()
                store.contentOffsetToken = scrollView.observe(\.contentOffset, options: options) { _, value in
                    if let newValue = value.newValue {
                        DispatchQueue.main.async {
                            geometry.contentOffset = newValue
                        }
                    }
                }

                store.contentSizeToken?.invalidate()
                store.contentSizeToken = scrollView.observe(\.contentSize, options: options) { _, value in
                    if let newValue = value.newValue {
                        DispatchQueue.main.async {
                            geometry.contentSize = newValue
                        }
                    }
                }

                store.contentInsetsToken?.invalidate()
                store.contentInsetsToken = scrollView.observe(\.contentInset, options: options) { _, value in
                    if let newValue = value.newValue {
                        DispatchQueue.main.async {
                            geometry.contentInsets = .init(
                                top: newValue.top,
                                leading: newValue.left,
                                bottom: newValue.bottom,
                                trailing: newValue.right
                            )
                        }
                    }
                }

                store.boundsToken?.invalidate()
                store.boundsToken = scrollView.observe(\.bounds, options: options) { _, value in
                    if let newValue = value.newValue {
                        DispatchQueue.main.async {
                            geometry.containerSize = newValue.size
                        }
                    }
                }
            }
            .backport
            .onChange(of: transform(geometry), action)
    }
}
