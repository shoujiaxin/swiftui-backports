//
//  ScrollGeometry.swift
//  SwiftUIBackports
//
//  Created by Jiaxin Shou on 2024/8/13.
//

import SwiftUI

@available(iOS 14.0, *)
public struct ScrollGeometry: Equatable, Sendable {
    /// The content offset of the scroll view.
    ///
    /// This is the position of the scroll view within its overall
    /// content size. This value may extend before zero or beyond
    /// the content size when the content insets of the scroll view
    /// are non-zero or when rubber banding.
    public var contentOffset: CGPoint

    /// The size of the content of the scroll view.
    ///
    /// Unlike the container size of the scroll view, this refers to the
    /// total size of the content of the scroll view which can be smaller
    /// or larger than its containing size.
    public var contentSize: CGSize

    /// The content insets of the scroll view.
    ///
    /// Adding these insets to the content size of the scroll view
    /// will give you the total scrollable space of the scroll view.
    public var contentInsets: EdgeInsets

    /// The size of the container of the scroll view.
    ///
    /// This is the overall size of the scroll view. Combining this
    /// and the content offset will give you the current visible rect
    /// of the scroll view.
    public var containerSize: CGSize

    /// The visible rect of the scroll view.
    ///
    /// This value is computed from the scroll view's content offset, content
    /// insets, and its container size.
    public var visibleRect: CGRect {
        .zero
    }

    /// The bounds rect of the scroll view.
    ///
    /// Unlike the visible rect, this value is within the content insets
    /// of the scroll view.
    public var bounds: CGRect {
        .init(origin: contentOffset, size: containerSize)
    }
}
