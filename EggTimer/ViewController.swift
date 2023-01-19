//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var player: AVAudioPlayer?
    let eggTimes=["Soft": 5, "Medium": 6, "Hard": 7]
    var seconds: Int = 0
    var total = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        seconds = (eggTimes[sender.currentTitle!]!)
        runTimer()
        total = (eggTimes[sender.currentTitle!]!)
        progressBar.progress = 0
        mainLabel.text = sender.currentTitle!
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds<1{
            timer.invalidate()
            mainLabel.text=("Done!")
            progressBar.progress = 1
            secondsLabel.text="0"
            playSound()
        } else {
            progressBar.progress = Float(total-seconds)/Float(total)
            secondsLabel.text = String(seconds)
            seconds -= 1     //This will decrement(count down)the seconds.
            
        }
        
    }
}



