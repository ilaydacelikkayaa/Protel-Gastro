//
//  NavigationRouter.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//
import SwiftUI
import Combine

final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
}
