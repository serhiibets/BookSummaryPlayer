//
//  AudioEngineProtocol.swift
//  BookPlayer
//
//  Created by Serhii Bets on 27/4/25.
//
//import AudioKit
//import Foundation
//import AVFAudio
//
//protocol AudioEngineProtocol {
//    var avEngine: AVAudioEngine { get }
//    var output: Node? { get set } 
//    func start() throws
//}
//
//protocol AudioPlayerProtocol: Node {
//    var isPlaying: Bool { get }
//    var isStarted: Bool { get }
//    var currentTime: TimeInterval { get }
//    var duration: TimeInterval { get }
//    
//    func play()
//    func pause()
//    func seek(time: TimeInterval)
//    func load(file: AVAudioFile) throws
//}
//
//extension AudioEngine: AudioEngineProtocol {}
//extension AudioPlayer: AudioPlayerProtocol {
//    func load(file: AVAudioFile) throws {}
//}
