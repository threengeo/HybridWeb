//
//  AppAlert.swift
//  HybridWeb
//
//  Created by nextez on 2022/05/02.
//

import Foundation

struct AppAlert: Identifiable {
    let id: UUID = UUID()
    let title: String
    let message: String
    
    init(_ title: String, _ message: String) {
        self.title = title
        self.message = message
    }
}
