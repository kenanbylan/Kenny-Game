import UIKit




class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    //Variable
    var score  = 0 ;
    var timer = Timer();
    var hideKennyTimer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var highScore = 0;
    
    //testing sourcetree
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //high score controll :
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0;
            highScoreLabel.text = "High Score: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text =  "High Score: \(highScore)"
        }
        
        
       
    
        scoreLabel.text = "Score : \(score)";
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 =  UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        
        
        timerFunction()
        hideKenny()
        
    }
    
    
    func timerFunction(){
        //Timers:
        counter = 10;
        timeLabel.text = "Score: \(score)";
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(countDown) , userInfo: nil, repeats: true)
        hideKennyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }

    
   @objc func hideKenny(){
        
        for kennys in kennyArray {
            kennys.isHidden = true
        }
        
        let randomNumber =  Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[randomNumber].isHidden = false
        
        
    }
    
    
    
    
    
    
    @objc func increaseScore(){
        
        score  += 1;
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown(){
       
        counter -= 1;
        timeLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideKennyTimer.invalidate()
            
            for kennys in kennyArray {
                kennys.isHidden = true
            }
            
            //High Score :
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text  = "High Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Over!", message:"Do you want to play again ?" , preferredStyle: UIAlertController.Style.alert)
            let okButton =  UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title:"Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //will write
                self.score  = 0;
                self.scoreLabel.text = "Score: \(self.score)"
                self.timeLabel.text = String(self.counter)
                
                
                self.timerFunction()
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true,completion: nil)
            
        }
    
}

}
