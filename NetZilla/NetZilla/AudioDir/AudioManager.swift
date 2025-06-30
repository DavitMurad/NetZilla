//
//  AudioManager.swift
//  NetZilla
//
//  Created by Davit Muradyan on 30.06.25.
//

import Foundation
import AVFoundation


class AudioManager: NSObject, AVAudioPlayerDelegate {
    static let shared = AudioManager()
    private var player: AVAudioPlayer?
    var onSoundEnded: (() -> Void)?

    func playSound(named name: String, onComplete: (() -> Void)? = nil) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
            self.onSoundEnded = onComplete
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onSoundEnded?()
        onSoundEnded = nil
    }
}
