//
//  MeditationView.swift
//  SwiftUI-AudioPlayer
//
//  Created by Bekzhan Talgat on 02.07.2023.
//

import SwiftUI

struct MeditationView: View {
    @StateObject var meditationVM: MeditationViewModel
    @State private var showPlayer: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Top background image
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
            
            
            // MARK: Meditation Details
            ZStack {
                // MARK: background color
                Color(red: 24/255, green: 23/255, blue: 22/255)
                
                
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: type & duration
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Music")
                        
                        Text(DateComponentsFormatter.abbreviated.string(from: meditationVM.meditation.duration) ?? meditationVM.meditation.duration.formatted()  + "S")
                    }
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)
                    
                    // MARK: Title
                    Text(meditationVM.meditation.title)
                        .font(.title)
                    
                    // MARK: Play button
                    Button {
                        showPlayer = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(20)
                    }

                    
                    // MARK: Description
                    Text(meditationVM.meditation.description)
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(20)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 3)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView(meditationVM: meditationVM, isPreview: false)
        }

    }
}

//struct MeditationView_Previews: PreviewProvider {
//    static let meditationVM = MeditationViewModel(meditation: .sss)
//
//    static var previews: some View {
//        MeditationView(meditationVM: meditationVM)
//            .environmentObject(AudioManager())
//    }
//}
