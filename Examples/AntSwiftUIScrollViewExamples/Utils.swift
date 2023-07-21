//
//  Utils.swift
//  AntSwiftUIScrollViewExamples
//
//  Created by HyunseokShim on 2023/07/21.
//

import Foundation
import SwiftUI

extension View {
    public func fillParent(alignment: Alignment) -> some View {
        return AnyView(self.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: alignment
        ))
    }
    
    public func fillWidth(alignment: Alignment) -> some View {
        return AnyView(self.frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: alignment
        ))
    }
    
    public func fillHeight(alignment: Alignment) -> some View {
        return AnyView(self.frame(
            minHeight: 0,
            maxHeight: .infinity,
            alignment: alignment
        ))
    }
    
    public func fillWidthFixedHeight(alignment: Alignment, height: CGFloat) -> some View {
        return AnyView(self.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: height,
            maxHeight: height,
            alignment: alignment
        ))
    }
    
    public func fillHeightFixedWidth(alignment: Alignment, width: CGFloat) -> some View {
        return AnyView(self.frame(
            minWidth: width,
            maxWidth: width,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: alignment
        ))
    }
    
    public func gone() -> some View {
        return AnyView(self.frame(
            width: 0,
            height: 0,
            alignment: .center
        ).padding(0).hidden())
    }
    
    public func padding(_ horizontal: CGFloat, _ vertical: CGFloat) -> some View {
        return AnyView(
            self.padding(EdgeInsets(
                top: vertical,
                leading: horizontal,
                bottom: vertical,
                trailing: horizontal
            )))
    }
}
