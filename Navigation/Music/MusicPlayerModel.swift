//
//  MusicPlayerModel.swift
//  Navigation
//
//  Created by Liz-Mary on 20.08.2023.
//

import Foundation
import AVFoundation

class MusicPlayerModel {
    
    var player: AVAudioPlayer?
    var currentTrackIndex = 0
    var trackFiles: [URL] = []
    var trackName: String = ""
    
    func loadAudioTracks() {
        if let trackDirectoryURL = Bundle.main.url(forResource: "Track", withExtension: nil) {
            do {
                trackFiles = try FileManager.default.contentsOfDirectory(at: trackDirectoryURL, includingPropertiesForKeys: nil, options: [])
            } catch {
                print("Error reading track directory:", error)
            }
        }
    }
    
    func loadAudioTrack(index: Int) {
        let fileURL = trackFiles[index]
        
        do {
            player = try AVAudioPlayer(contentsOf: fileURL)
            player?.prepareToPlay()
            trackName = fileURL.deletingPathExtension().lastPathComponent
        } catch {
            print("Error creating AVAudioPlayer:", error)
        }
    }
}
