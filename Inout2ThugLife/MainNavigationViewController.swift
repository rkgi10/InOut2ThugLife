//
//  FirstViewController.swift
//  Inout2ThugLife
//
//  Created by Rohit Gurnani on 31/10/15.
//  Copyright © 2015 Rohit Gurnani. All rights reserved.
//

import UIKit
import ChameleonFramework
import AVFoundation

class FirstViewController: UIViewController {
    
    let speechSynthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.flatBrownColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func speak() {
        let speakString = "आपका स्वागत है यहाँ तीन विकल्प हैं आप एक दवा और इसकी लागत का पता लगाएं आप पास के अस्पतालों और उनकी जानकारी पा सकते हैं आप प्राथमिक चिकित्सा के बारे में सीख सकते हैं "
        
        let speechUtterance = AVSpeechUtterance(string: speakString)
        
        
        speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
        
        speechUtterance.rate = 0.25
        speechUtterance.pitchMultiplier = 0.25
        speechUtterance.volume = 0.75
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "hi-IN")
        speechSynthesizer.speakUtterance(speechUtterance)
    }
    
    func stopSpeech() {
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Word)
    }
    var i = 0
    @IBAction func help()
    {
        if (i % 2 == 0)
        {
            stopSpeech()
            i++
        }
        else
        {
            speak()
            i++
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

