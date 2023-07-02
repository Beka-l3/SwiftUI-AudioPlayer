//
//  SwiftUI_AudioPlayerApp.swift
//  SwiftUI-AudioPlayer
//
//  Created by Bekzhan Talgat on 02.07.2023.
//

import SwiftUI

@main
struct SwiftUI_AudioPlayerApp: App {
    @State var audioManager: AudioManager = .init()
    let meditationVM = MeditationViewModel(meditation: .sss)
    
    var body: some Scene {
        WindowGroup {
            MeditationView(meditationVM: meditationVM)
                .preferredColorScheme(.dark)
                .environmentObject(audioManager)
            
        }
    }
}
