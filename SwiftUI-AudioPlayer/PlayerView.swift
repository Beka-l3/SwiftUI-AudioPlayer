//
//  PlayerView.swift
//  SwiftUI-AudioPlayer
//
//  Created by Bekzhan Talgat on 02.07.2023.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    
    var meditationVM: MeditationViewModel
    var isPreview: Bool
    
    @State private var value: Double = 0.0
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @State private var isEditing: Bool = false

    
    var body: some View {
        ZStack {
            // MARK: Background Image
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
                
            // MARK: Blur
            
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                
                HStack {
                    Button {
                        audioManager.stop()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                // MARK: Title
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                    
                Spacer()
                
                if let player = audioManager.player {
                    // MARK: Playback
                    VStack(spacing: 5) {
                        // MARK: Playback Timeline
                        Slider(value: $value, in: 0...player.duration) { editing in
                            isEditing = editing
                            
                            if !editing {
                                player.currentTime = value
                            }
                        }
                        .tint(.white)
                        
                        // MARK: Playback Time
                        HStack {
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            
                            Spacer()
                            
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                    
                    
                    // MARK: Playback control
                    HStack(spacing: 44) {
                        // MARK: Repeat button
                        let color: Color = audioManager.isLooping ? .teal : .white
                        PlaybackControlButton(systemName: "repeat", color: color) {
                            audioManager.toggleLooping()
                        }
                        
                        // MARK: Backward button
                        PlaybackControlButton(systemName: "gobackward.10") {
                            player.currentTime -= 10
                        }
                        
                        // MARK: Play/Pause button
                        PlaybackControlButton(systemName: audioManager.isPLaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                            audioManager.playPause()
                        }
                        
                        // MARK: Forward button
                        PlaybackControlButton(systemName: "goforward.10") {
                            player.currentTime += 10
                        }
                        
                        // MARK: Stop button
                        PlaybackControlButton(systemName: "stop.fill") {
                            audioManager.stop()
                            dismiss()
                        }
                    }
                }
            }
            .padding(20)
        }
        .onAppear {
            audioManager.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player else {
                return
            }
            if !isEditing {
                value = player.currentTime
            }
        }
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    static let meditationVM = MeditationViewModel(meditation: .sss)
//
//    static var previews: some View {
//        PlayerView(meditationVM: meditationVM, isPreview: true)
//            .environmentObject(AudioManager())
//    }
//}
