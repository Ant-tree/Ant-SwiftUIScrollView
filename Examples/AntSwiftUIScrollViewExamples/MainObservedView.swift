//
//  MainObservedView.swift
//  AntSwiftUIScrollViewExamples
//
//  Created by HyunseokShim on 2023/07/21.
//

import Foundation
import SwiftUI

class MainObservedView: ObservableObject {
    
    @Published var rootWindowRect: CGRect = CGRect()
    @Published var rootWindow: UIWindow? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
}
