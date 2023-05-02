//
//  ReadMeApp.swift
//  ReadMe
//
//  Created by Guilherme de Carvalho Correa on 24/04/23.
//

import SwiftUI

@main
struct ReadMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(Library())
        }
    }
}
