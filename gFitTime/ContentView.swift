//
//  ContentView.swift
//  gFitTime
//
//  Created by angi1g on 19/01/24.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var timerSeconds = 0
    @State private var timerRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color("colorCF")
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("logoCF")
                    .resizable()
                    .scaledToFit()
                Spacer()
                Spacer()
                
                Text(secondsToFormattedString(timerSeconds))
                    .font(.system(size: 100, weight: .bold))
                    .opacity(0.80)
                    .foregroundColor(.white)
                Spacer()
                
                HStack {
                    Button() {
                        timerRunning = true
                    } label: {
                        Image(systemName: "figure.strengthtraining.traditional")
                    }
                    .foregroundColor(.green)
                    Spacer()
                    Button() {
                        timerRunning = false
                    } label: {
                        Image(systemName: "figure.mind.and.body")
                    }
                    .foregroundColor(.white)
                    Spacer()
                    Button() {
                        timerRunning = false
                        timerSeconds = 0
                    } label: {
                        Image(systemName: "figure.cooldown")
                    }
                    .foregroundColor(.red)
                }
                .font(.system(size: 60, weight: .bold))
                .padding()
                Spacer()
                Spacer()
            }
            .padding()
            .onReceive(timer) { _ in
                if timerRunning {
                    if timerSeconds%60 == 59 {
                        AudioServicesPlaySystemSound(1013)
                    }
                    timerSeconds += 1
                }
            }
        }
        .onAppear(perform: {
            UIApplication.shared.isIdleTimerDisabled = true
        })
        .onDisappear(perform: {
            UIApplication.shared.isIdleTimerDisabled = false
        })
    }
    
    func secondsToFormattedString (_ seconds: Int) -> String {
        return String(format: "%02i:%02i", seconds / 60, seconds % 60)
    }
}

#Preview {
    ContentView()
}
