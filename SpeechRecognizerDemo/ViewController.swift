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
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(localeIdentifier: "en_US"))
        
        // Check the availability. It currently only works on the device
        if (speechRecognizer?.isAvailable == false) {
            print("Speech recognizer is not available!")
            return
        }
        
        // Grab a local audio sample to parse
        let filePath: String = Bundle.main().pathForResource("sample2", ofType: "mp3")!
        print("\(filePath)")
        let fileURL: NSURL = URL(fileURLWithPath: filePath)
        
        // Get the party started and watch for results in the completion block.
        // It gets fired every time a new word (aka transcription) gets detected.
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: fileURL as URL)
        recognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            print (result?.bestTranscription.formattedString)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

