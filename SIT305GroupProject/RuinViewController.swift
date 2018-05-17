//
//  ChurchViewController.swift
//  SIT305GroupProject
//
//  Created by JOHN YU on 15/5/18.
//  Copyright © 2018 SIT305. All rights reserved.
//

import UIKit

class RuinViewController: UIViewController {
    var actions = NSMutableArray.init();
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var healthBar: UISlider!
    @IBOutlet weak var bgImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefault = UserDefaults.standard;
        
        actions.add("Unfortunately, you have meet monster inside the ruin which cause you lose 20% HP.");
        actions.add("You have meet the kind dragon which recover 10% HP");
        actions.add("You have see the beautiful starry sky, Which recover you with 10% HP.");
        
        if userDefault.bool(forKey: "GetRuinWinkey") == false{
            actions.add("You have meet the alien which tell you the new technology. (+10% wining point)");
        }
        
        let progress = userDefault.float(forKey: "ProgressKey");
        let health = userDefault.float(forKey: "HealthPercentKey");
        
        progressBar.value = progress;
        healthBar.value = health;
        // Do any additional setup after loading the view.
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func backClickAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func actionChooseClick(_ sender: Any) {
        let userDefault = UserDefaults.standard;
        
        let index = arc4random()%UInt32(actions.count);
        stateLabel.text = (actions.object(at: Int(index)) as! String);
        if stateLabel.text == "Unfortunately, you have meet monster inside the ruin which cause you lose 20% HP."
        {
            healthBar.value = healthBar.value - 0.3;
            stateImage.image = UIImage.init(named: "monster.jpg");
        }
        else if stateLabel.text == "You have meet the kind dragon which recover 10% HP"
        {
            healthBar.value = healthBar.value + 0.05;
            stateImage.image = UIImage.init(named: "dragon.jpg");
        }
        else if stateLabel.text == "You have meet the alien which tell you the new technology. (+10% wining point)"
        {
            progressBar.value = progressBar.value + 0.1;
            stateImage.image = UIImage.init(named: "alien.jpg");
            actions.remove("You have meet the alien which tell you the new technology. (+10% wining point)");
            userDefault.set(true, forKey: "GetRuinWinkey");
            userDefault.synchronize();
        }
        else if stateLabel.text == "You have see the beautiful starry sky, Which recover you with 10% HP."
        {
            healthBar.value = healthBar.value + 0.1;
            stateImage.image = UIImage.init(named: "star.jpg");
        }
        
        self.checkDeathOrWin();
    }
    
    func checkDeathOrWin() {
        
        let userDefault = UserDefaults.standard;
        
        if healthBar.value > 1{
            healthBar.value = 1;
        }
        
        if progressBar.value == 1 {
            //Win
            self.present((self.storyboard?.instantiateViewController(withIdentifier: "WinViewController"))!, animated: true, completion: nil);
            let userDefault = UserDefaults.standard;
            userDefault.set(0.0, forKey: "ProgressKey");
            userDefault.set(1, forKey: "HealthPercentKey");
            userDefault.synchronize();
        }else{
            userDefault.set(progressBar.value, forKey: "ProgressKey");
            userDefault.synchronize();
        }
        
        if healthBar.value <= 0 {
            //dead
            self.present((self.storyboard?.instantiateViewController(withIdentifier: "DeadViewController"))!, animated: true, completion: nil);
            let userDefault = UserDefaults.standard;
            userDefault.set(0.0, forKey: "ProgressKey");
            userDefault.set(1, forKey: "HealthPercentKey");
            userDefault.synchronize();
        }else{
            userDefault.set(healthBar.value, forKey: "HealthPercentKey");
            userDefault.synchronize();
        }
    }
}


