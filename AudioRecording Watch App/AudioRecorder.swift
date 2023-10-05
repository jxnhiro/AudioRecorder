//
//  AudioRecorder.swift
//  AudioRecording Watch App
//
//  Created by Kenny Jinhiro Wibowo on 05/10/23.
//

import Foundation
import SwiftUI
import AVFoundation

class AudioRecorder: ObservableObject {
    
    private var audioRecorder: AVAudioRecorder
    
    @Published var recording: Bool = false
    
    init() {
        
        let audioSession = AVAudioSession.sharedInstance()
        let audioApplication = AVAudioApplication.shared
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 48000.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        // Ask for permission for the mic from the user. This is registered in the info.plit file.
        if AVAudioApplication.shared.recordPermission != .granted {
            AVAudioApplication.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
                }
            }
        }
        
        do {
            self.audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func startRecording(){
        self.audioRecorder.record()
        self.recording = true
    }
    
    func stopRecording(){
        self.audioRecorder.stop()
        self.recording = false
    }
    
}
