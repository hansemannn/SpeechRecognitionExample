//
//  ViewController.swift
//  SpeechRecognizerDemo
//
//  Created by Hans Knöchel on 14.06.16.
//  Copyright © 2016 Appcelerator. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate {

    @IBAction func didTapSpeechRecognitionButton() {
        
        // Initialize the speech recogniter with your preffered language
        guard let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en_US")) else {
            print("Speech recognizer is not available for this locale!")
            return
        }
        
        // Check the availability. It currently only works on the device
        if (speechRecognizer.isAvailable == false) {
            print("Speech recognizer is not available for this device!")
            return
        }
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if (authStatus == .authorized) {
                // Grab a local audio sample to parse
                let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "one_more_thing", ofType: "mp3")!)
                
                // Get the party started and watch for results in the completion block.
                // It gets fired every time a new word (aka transcription) gets detected.
                let request = SFSpeechURLRecognitionRequest(url: fileURL)
                
                speechRecognizer.recognitionTask(with: request, resultHandler: { (result, error) in
                    print(result?.bestTranscription ?? "")
                    
                    if (result?.isFinal)! {
                        let alert = UIAlertController(title: "Speech recognition completed!", message: result?.bestTranscription.formattedString, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.show(alert, sender: self)
                    }
                })
            } else {
                print("Error: Speech-API not authorized!");
            }
        }
    }
    
    // MARK: Speech Recognizer Delegate (only called when using the advanced recognition technique)
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        print("SpeechRecognizer available: \(available)")
    }

    // MARK: Speech Recognizer Task Delegate
    
    func speechRecognitionDidDetectSpeech(_ task: SFSpeechRecognitionTask) {
        print("speechRecognitionDidDetectSpeech")
    }
    
    func speechRecognitionTaskFinishedReadingAudio(_ task: SFSpeechRecognitionTask) {
        print("speechRecognitionTaskFinishedReadingAudio")
    }
    
    func speechRecognitionTaskWasCancelled(_ task: SFSpeechRecognitionTask) {
        print("speechRecognitionTaskWasCancelled")
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        print("didFinishSuccessfully")
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didRecord audioPCMBuffer: AVAudioPCMBuffer) {
        print("didRecord")
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didHypothesizeTranscription transcription: SFTranscription) {
        print("didHypothesizeTranscription")
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        print("didFinishRecognition")
    }
}

