//
//  MusicPlayerViewController.swift
//  Navigation
//
//  Created by Liz-Mary on 19.08.2023.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var currentTrackIndex = 0
    var trackFiles: [URL] = []
    
    private lazy var playPauseButton: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "play.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.tintColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playPauseButtonTapped))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var stopButton: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "stop.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stopButtonTapped))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var forwardButton: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "forward.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forwardButtonTapped))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var backwardButton: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "backward.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backwardButtonTapped))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    private lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadAudioTracks()
    }
    
    private func setupUI() {
        view.addSubview(playPauseButton)
        view.addSubview(stopButton)
        view.addSubview(trackLabel)
        view.addSubview(forwardButton)
        view.addSubview(backwardButton)
        
        NSLayoutConstraint.activate([
            trackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            trackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            playPauseButton.widthAnchor.constraint(equalToConstant: 60),
            playPauseButton.heightAnchor.constraint(equalToConstant: 60),
            
            stopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
            stopButton.widthAnchor.constraint(equalToConstant: 60),
            stopButton.heightAnchor.constraint(equalToConstant: 60),
            
            forwardButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20),
            forwardButton.centerXAnchor.constraint(equalTo: stopButton.centerXAnchor),
            forwardButton.widthAnchor.constraint(equalToConstant: 60),
            forwardButton.heightAnchor.constraint(equalToConstant: 60),
            
            backwardButton.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 20),
            backwardButton.centerXAnchor.constraint(equalTo: playPauseButton.centerXAnchor),
            backwardButton.widthAnchor.constraint(equalToConstant: 60),
            backwardButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    private func loadAudioTracks() {
            if let trackDirectoryURL = Bundle.main.url(forResource: "Track", withExtension: nil) {
                do {
                    trackFiles = try FileManager.default.contentsOfDirectory(at: trackDirectoryURL, includingPropertiesForKeys: nil, options: [])
                    
                    if trackFiles.isEmpty {
                        print("No audio tracks found in the directory.")
                    } else {
                        loadAudioTrack(index: currentTrackIndex)
                    }
                } catch {
                    print("Error reading track directory:", error)
                }
            }
        }
        
        private func loadAudioTrack(index: Int) {
            let fileURL = trackFiles[index]
            
            do {
                player = try AVAudioPlayer(contentsOf: fileURL)
                player?.prepareToPlay()
                
                let trackName = fileURL.deletingPathExtension().lastPathComponent
                trackLabel.text = trackName
            } catch {
                print("Error creating AVAudioPlayer:", error)
            }
        }
    
    @objc func playPauseButtonTapped(_ sender: Any) {
        if let player = player {
            if player.isPlaying {
                player.pause()
                playPauseButton.image = UIImage(systemName: "play.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            } else {
                player.play()
                playPauseButton.image = UIImage(systemName: "pause.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    @objc func stopButtonTapped(_ sender: Any) {
        if let player = player {
            player.stop()
            player.currentTime = 0
            playPauseButton.image = UIImage(systemName: "play.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }
    
    @objc private func forwardButtonTapped() {
        if currentTrackIndex < trackFiles.count - 1 {
            currentTrackIndex += 1
            loadAudioTrack(index: currentTrackIndex)
            player?.play()
        }
    }
    
    @objc private func backwardButtonTapped() {
        if currentTrackIndex > 0 {
            currentTrackIndex -= 1
            loadAudioTrack(index: currentTrackIndex)
            player?.play()
        }
    }
}
