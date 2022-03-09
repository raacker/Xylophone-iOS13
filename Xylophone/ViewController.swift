//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let DIM_DURATION = 0.2
    
    enum ButtonType : Int, CustomStringConvertible {
        case C = 0, D, E, F, G, A, B
        
        var description: String {
            switch (self)
            {
            case .C: return "C";
            case .D: return "D";
            case .E: return "E";
            case .F: return "F";
            case .G: return "G";
            case .A: return "A";
            case .B: return "B";
            }
        }
    }
    
    @IBOutlet var buttons: [UIButton]!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        if let buttonType = ButtonType(rawValue: sender.tag) {
            UIView.animate(withDuration: self.DIM_DURATION) {
                sender.alpha = 0.7
            }
            playSound(buttonType);
            DispatchQueue.main.asyncAfter(deadline: .now() + self.DIM_DURATION) {
                UIView.animate(withDuration: self.DIM_DURATION) {
                    sender.alpha = 1.0
                }
            }
        }
        else {
            print ("Insufficient sound request")
        }
    }
    
    func playSound(_ type: ButtonType) {
        guard let sound = Bundle.main.url(forResource: type.description, withExtension: "wav")
        else {
            return;
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: sound, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

