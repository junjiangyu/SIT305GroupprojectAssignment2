//
//  BeachViewController.swift
//  SIT305GroupProject
//
//  Created by Juncheng wang on 8/5/18.
//  Copyright © 2018 SIT305. All rights reserved.
//

import UIKit

class BeachViewController: UIViewController {
    
    var actions = NSMutableArray.init();
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var healthBar: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = UserDefaults.standard;
        
        // Do any additional setup after loading the view.
        if userDefault.bool(forKey: "GetBeachWinKey") == false{
            actions.add("There are some shafts inside this direction. Collect it (+25% winning point)");
        }
        actions.add("You have meet the kind SpongeBob SquarePants. Which recover you with 20% HP");
        actions.add("There are some bad crab and fish inside this direction, you don't know and eat them. (-20% HP)");
        actions.add("There is nothing inside this direction which looks barren");
        
        
        
        let progress = userDefault.float(forKey: "ProgressKey");
        let health = userDefault.float(forKey: "HealthPercentKey");
        
        progressBar.value = progress;
        healthBar.value = health;
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
    
    @IBAction func chooseActions(_ sender: UIButton) {
        let userDefault = UserDefaults.standard;
        
        let index = arc4random()%UInt32(actions.count);
        stateLabel.text = (actions.object(at: Int(index)) as! String);
        if stateLabel.text == "There are some shafts inside this direction. Collect it (+25% winning point)"
        {
            progressBar.value = progressBar.value + 0.25;
            actions.remove("There are some shafts inside this direction. Collect it (+25% winning point)");
            userDefault.set(true, forKey: "GetBeachWinKey");
        }
        else if stateLabel.text == "You have meet the kind SpongeBob SquarePants. Which recover you with 20% HP"
        {
            healthBar.value = healthBar.value + 0.2;
            stateImage.image = UIImage.init(named: "spongebob.jpg");
        }
        else if stateLabel.text == "There are some bad crab and fish inside this direction, you don't know and eat them. (-20% HP)"
        {
            healthBar.value = healthBar.value - 0.2;
            stateImage.image = UIImage.init(named: "crab.jpg");
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
