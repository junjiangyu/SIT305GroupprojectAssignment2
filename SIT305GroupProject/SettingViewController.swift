//
//  SettingViewController.swift
//  SIT305GroupProject
//
//  Created by JOHN YU on 8/5/18.
//  Copyright © 2018 SIT305. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var forestBtn: UIButton!

    @IBOutlet weak var musicSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = UserDefaults.standard;
        
        
        let bgimageName = userDefault.string(forKey: "GameBackground");
        if bgimageName == nil || bgimageName == "background.jpg" {
            forestBtn.layer.borderWidth = 3;
            forestBtn.layer.borderColor = UIColor.white.cgColor;
            cityBtn.layer.borderWidth = 0;
        }else{
            cityBtn.layer.borderWidth = 3;
            cityBtn.layer.borderColor = UIColor.white.cgColor;
            forestBtn.layer.borderWidth = 0;
        }
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
    
    
    @IBAction func musicSwitchAction(_ sender: UISwitch) {
        let userDefault = UserDefaults.standard;
        if sender.isOn {
            BackGroundMusicManger.shareManger.playMusic();
            userDefault.set(true, forKey: "playMusic");
        }else{
            BackGroundMusicManger.shareManger.stopMusic();
            userDefault.set(false, forKey: "playMusic");
        }
        userDefault.synchronize();
    }
    
    @IBAction func forestThemeClick(_ sender: Any) {
        let userDefault = UserDefaults.standard;
        userDefault.set("background.jpg", forKey: "GameBackground")
        userDefault.synchronize();
        forestBtn.layer.borderWidth = 3;
        forestBtn.layer.borderColor = UIColor.white.cgColor;
        cityBtn.layer.borderWidth = 0;
        
    }
    @IBAction func cityThemeClick(_ sender: Any) {
        let userDefault = UserDefaults.standard;
        userDefault.set("background2.jpeg", forKey: "GameBackground")
        userDefault.synchronize();
        cityBtn.layer.borderWidth = 3;
        cityBtn.layer.borderColor = UIColor.white.cgColor;
        forestBtn.layer.borderWidth = 0;
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
}
