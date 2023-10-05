//
//  ContentView.swift
//  AudioRecording Watch App
//
//  Created by Kenny Jinhiro Wibowo on 05/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    var body: some View {
        VStack {
            Button{
                if self.audioRecorder.recording{
                    audioRecorder.stopRecording()
                } else {
                    self.audioRecorder.startRecording()
                }
            } label: {
                Image(systemName:"mic.fill.badge.plus")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(self.audioRecorder.recording ? .red: .green)
                    .frame(width: 35, height: 35)
            }
            Text(audioRecorder.recording ? "Recording.." : "Record")
                .font(.caption)
                .bold()
                .foregroundStyle(self.audioRecorder.recording ? .green : .red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
