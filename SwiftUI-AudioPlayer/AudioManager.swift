//
//  AudioManager.swift
//  SwiftUI-AudioPlayer
//
//  Created by Bekzhan Talgat on 02.07.2023.
//

import Foundation
import AVKit

final class AudioManager: ObservableObject {
    
    var player: AVAudioPlayer?
    @Published private(set) var isPLaying: Bool = false
    @Published private(set) var isLooping: Bool = false
    
    func startPlayer(track: String, isPreview: Bool = false) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print("Could not find resourse: \(track), with extension mp3")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            
            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPLaying = true
            }
        } catch {
            print("Failer to initialize player: \(error)")
        }
    }
    
    func playPause() {
        guard let player = player else {
            print("No player")
            return
        }
        
        if player.isPlaying {
            player.pause()
            isPLaying = false
        } else {
            player.play()
            isPLaying = true
        }
    }
    
    func stop() {
        guard let player = player else {
            print("No player")
            return
        }
        
        if player.isPlaying {
            player.stop()
            isPLaying = false
        }
    }
    
    func toggleLooping() {
        guard let player = player else {
            print("No player")
            return
        }
        
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLooping = player.numberOfLoops != 0
    }
}
