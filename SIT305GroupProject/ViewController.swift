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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
        
            self.startNewGame();
        
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
        userDefault.synchronize();
        
        self.present(vc, animated: true, completion: nil);
    }
    
}
