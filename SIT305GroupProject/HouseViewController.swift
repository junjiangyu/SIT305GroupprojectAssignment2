//
//  HouseViewController.swift
//  SIT305GroupProject
//
//  Created by JOHN YU on 15/5/18.
//  Copyright © 2018 SIT305. All rights reserved.
//
import UIKit

class HouseViewController: UIViewController {
    var actions = NSMutableArray.init();
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var healthBar: UISlider!
    @IBOutlet weak var bgImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefault = UserDefaults.standard;
        
        actions.add("Unfortunately, the house got crashed which falling down get you lose 30% HP.");
        actions.add("You have found some bread inside the house. Collect to recover HP 10%");
        actions.add("You have found some meat inside the house, Collect to recover HP 10%.");
        
        if userDefault.bool(forKey: "GetHouseWinKey") == false{
            actions.add("You have found some gears inside this direction, take it inside to your backpack. (+25% wining point)");
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
        if stateLabel.text == "Unfortunately, the house got crashed which falling down get you lose 30% HP."
        {
            healthBar.value = healthBar.value - 0.5;
            stateImage.image = UIImage.init(named: "falling.jpeg");
        }
        else if stateLabel.text == "You have found some bread inside the house. Collect to recover HP 10%"
        {
            healthBar.value = healthBar.value + 0.1;
            stateImage.image = UIImage.init(named: "bread.jpeg");
        }
        else if stateLabel.text == "You have found some gears inside this direction, take it inside to your backpack. (+25% wining point)"
        {
            progressBar.value = progressBar.value + 0.25;
            actions.remove("You have found some gears inside this direction, take it inside to your backpack. (+25% wining point)");
            userDefault.set(true, forKey: "GetHouseWinKey");
            userDefault.synchronize();
        }
        else if stateLabel.text == "You have found some meat inside the house, Collect to recover HP 10%."{
            healthBar.value = healthBar.value + 0.1;
            stateImage.image = UIImage.init(named: "meat.jpeg");
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
