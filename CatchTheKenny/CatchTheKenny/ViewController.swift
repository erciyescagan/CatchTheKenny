//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Mert Erciyes Çağan on 5/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var timerKenny = Timer()
    var counter = 0
    var kennyArr = [UIImageView]()
    var highscore = 0
    
    override func viewDidLoad() {
        
        counter = 10
        timeLabel.text = "\(counter)"
       
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highscore = 0
        }
        
        if let newScore = storedHighscore as? Int {
            highscore = newScore
        }

        highscoreLabel.text = "Highscore: \(highscore)"

        setTimers()
        
       super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        gestureRecognizers()
     
        kennyArr = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        hideKenny()
    }
    
    @objc func hideKenny(){
        for kenny in kennyArr {
            kenny.isHidden = true;
        }
        kennyArr[Int(arc4random_uniform(UInt32(kennyArr.count - 1)))].isHidden = false
    }


    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        if score > highscore {
            highscore = score
            highscoreLabel.text = "Highscore: \(highscore)"
            UserDefaults.standard.set(highscore, forKey: "highscore")
        }
    }
    
    @objc func countdown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter <= 0 {
            timer.invalidate()
            timerKenny.invalidate()
            for kenny in kennyArr {
                kenny.isHidden = true;
            }
            
            if self.score > self.highscore {
                self.highscore = self.score
                highscoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time is Up!", message: "You wanna play again?", preferredStyle: UIAlertController.Style.alert)

            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
            
                self.setTimers()
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated:true, completion: nil)
            
        }
    }
    
    func setTimers(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
        
        self.timerKenny = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
        
    }
    
    func gestureRecognizers(){
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)

    }
}

