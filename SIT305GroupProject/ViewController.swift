//
//  ViewController.swift
//  SIT305GroupProject
//
//  Created by JOHN YU on 18/4/18.
//  Copyright © 2018 SIT305. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        BackGroundMusicManger.shareManger.setupMusicPlayer();
        
        let userDefault = UserDefaults.standard;
        
        let haveMusic = userDefault.bool(forKey: "playMusic");
        
        if haveMusic {
            BackGroundMusicManger.shareManger.playMusic();
        }else{
            BackGroundMusicManger.shareManger.stopMusic();
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefault = UserDefaults.standard;
        var bgimageName = userDefault.string(forKey: "GameBackground");
        
        if bgimageName == nil {
            bgimageName = "background.jpg";
        }
        bgImage.image = UIImage.init(named: bgimageName!);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGameClick(_ sender: Any) {
        
        let userDefault = UserDefaults.standard;
        
        let progress = userDefault.float(forKey: "ProgressKey");
        
        if progress > 0{
            let alert = UIAlertController.init(title: nil, message: "You have unfinished game, do you want to restart?", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.startNewGame();
            }))
            alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: nil));
            
            self.present(alert, animated: true, completion: nil);
        }else{
            
            self.startNewGame();
        }
        
    }
    
    
    @IBAction func ContinueGame(_ sender: Any) {
        
        let userDefault = UserDefaults.standard;
        
        let progress = userDefault.float(forKey: "ProgressKey");
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewContorller") as! MainViewController;
        
        
        if progress <= 0{
            let alert = UIAlertController.init(title: nil, message: "You DO NOT have any unfinished game.", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }else{
            self.present(vc, animated: true, completion: nil);
        }
    }
    
    /// start a new game with default data;
    func startNewGame() {
        let userDefault = UserDefaults.standard;
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewContorller") as! MainViewController;
        
        userDefault.set(0.0, forKey: "ProgressKey");
        userDefault.set(1, forKey: "HealthPercentKey");
        userDefault.set(false, forKey: "GetForestWinKey1");
        userDefault.set(false, forKey: "GetForestWinKey2");
        userDefault.set(false, forKey: "GetBeachWinKey");
        userDefault.set(false, forKey: "GetHarborWinKey");
        userDefault.set(false, forKey: "GetAirportWinKey");
        userDefault.set(false, forKey: "GetHouseWinKey");
        userDefault.set(false, forKey: "GetChurchWinkey");
        userDefault.set(false, forKey: "GetRuinWinkey");
        userDefault.set(false, forKey: "GetSchoolWinKey");
        userDefault.synchronize();
        
        self.present(vc, animated: true, completion: nil);
    }
    
}
