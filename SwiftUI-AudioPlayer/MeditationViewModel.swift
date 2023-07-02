//
//  MeditationViewModel.swift
//  SwiftUI-AudioPlayer
//
//  Created by Bekzhan Talgat on 02.07.2023.
//

import Foundation

final class MeditationViewModel: ObservableObject {
    private(set) var meditation: Meditation
    
    init(meditation: Meditation) {
        self.meditation = meditation
    }
}

struct Meditation {
    let id = UUID()
    
    let title: String
    let description: String
    let duration: TimeInterval
    let track: String
    let image: String
    
    static let sss: Meditation = .init(
        title: "1 Minute Relaxing Meditation",
        description: "Just waking up in the morning, gotta thank god. I duno, but today seems kinda odd. No barking from the dog, no smog. And momma cooked a breakfast with no hug",
        duration: 70,
        track: "Wait A Minute",
        image: "Background Image"
    )
}
