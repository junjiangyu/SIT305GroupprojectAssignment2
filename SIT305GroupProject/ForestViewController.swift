//
//  ForestViewController.swift
//  SIT305GroupProject
//
//  Created by JOHN YU on 27/4/18.
//  Copyright © 2018 SIT305. All rights reserved.
//

import UIKit

public enum ActionType : Int {
    
    case baseAction
    
    case treeAction
    
    case holeAction
    
    case glassAction
    
    case houseAction
}

class ForestViewController: UIViewController {
    
    var baseActions = NSMutableArray.init();
    var treeActions = NSMutableArray.init();
    var holeActions = NSMutableArray.init();
    var glassActions = NSMutableArray.init();
    var houseActions = NSMutableArray.init();
    
    var userActionType = ActionType.baseAction;
    
    var actionCount = 0;
    
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var stateImage: UIImageView!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var healthBar: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = UserDefaults.standard;
        
        // Do any additional setup after loading the view.
        
        baseActions.add("The trees look wet, climb upstairs to see what is up?");
        baseActions.add("There is a hole in front of you, looks scared and cold. Walk inside?");
        baseActions.add("There is something shiny inside the grass. Look of it?");
        baseActions.add("There is a wood house in front of you. Go inside and find what u got?");
        
        treeActions.add("The trees got so many apples inside, collect the apples. (HP+20%)");
        treeActions.add("You have fell from the trees. HP-30%. (Directly back to forest)");
        treeActions.add("You have been attacked by the bees. HP-20%.");
        treeActions.add("Climb down from trees.");
        treeActions.add("There is some honey in front of you. Collect the honey.");
        
        
        holeActions.add("There is a huge bear in front of you. It slapped you with hard attack. (HP-40%)");
        
        if userDefault.bool(forKey: "GetForestWinKey1") == false{
            glassActions.add("here are some gears inside this grass, congregations! (+ 15% winning point)");
        }
        if userDefault.bool(forKey: "GetForestWinKey2") == false{
            glassActions.add("There are some shafts inside the grass. (+10% winning point)");
        }
        
        houseActions.add("Find some bread inside this house. (HP+10%)");
        houseActions.add("Go sleep inside this house. (HP+20%)");
        houseActions.add("The house is so old which felling down makes you get hurt. (HP-20%)");
        
        
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
    
    

    @IBAction func backClickAction(_ sender: UIButton) {
        if userActionType == ActionType.baseAction {
            self.dismiss(animated: true, completion: nil);
        }else{
            userActionType = ActionType.baseAction;
        }
        stateLabel.text = " You have walked inside the forest. The rainy smell makes you feel uncomfortable. But to survive inside, you will need to find food and get familiar with this island first. Choose the action below you want to act:";
        stateImage.image = UIImage.init(named: "forest.jpg");
    }
    
    
    @IBAction func actionChooseClick(_ sender: Any) {
        let userDefault = UserDefaults.standard;
        
        switch userActionType {
        case .baseAction:
            let index = arc4random()%UInt32(baseActions.count);
            stateLabel.text = (baseActions.object(at: Int(index)) as! String);
            switch baseActions.index(of: stateLabel.text as Any){
            case 0:
                userActionType = ActionType.treeAction;
            case 1:
                userActionType = ActionType.holeAction;
            case 2:
                userActionType = ActionType.glassAction;
            case 3:
                userActionType = ActionType.houseAction;
            default:
                return;
            }
        case .treeAction:
            var index = arc4random()%UInt32(treeActions.count-1);
            
            if actionCount > 50{
                index = arc4random()%UInt32(treeActions.count)
            }
            
            stateLabel.text = (treeActions.object(at: Int(index)) as! String);
            
            if(stateLabel.text == "You have fell from the trees. HP-30%. (Directly back to forest)" ||
                stateLabel.text == "Climb down from trees."){
                
                userActionType = ActionType.baseAction;
                
                if stateLabel.text == "You have fell from the trees. HP-30%. (Directly back to forest)"
                {
                    healthBar.value = healthBar.value - 0.3;
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0)
                {
                    self.stateLabel.text = " You have walked inside the forest. The rainy smell makes you feel uncomfortable. But to survive inside, you will need to find food and get familiar with this island first. Choose the action below you want to act:";
                }
            }
            else if stateLabel.text == "There is some honey in front of you. Collect the honey."
            {
                holeActions.add("Use the honey for the bear, and it looks kind and nice after that. And you have found the signal guns inside the hole! (You win!)");
            }
            else if stateLabel.text == "You have been attacked by the bees. HP-20%."
            {
                healthBar.value = healthBar.value - 0.2;
            }
            else if stateLabel.text == "The trees got so many apples inside, collect the apples. (HP+20%)"
            {
                healthBar.value = healthBar.value + 0.2
            }
        case .holeAction:
            let index = arc4random()%UInt32(holeActions.count);
            stateLabel.text = (holeActions.object(at: Int(index)) as! String);
            if stateLabel.text == "There is a huge bear in front of you. It slapped you with hard attack. (HP-40%)"
            {
                healthBar.value = healthBar.value - 0.4;
                stateImage.image = UIImage.init(named: "bear.jpg");
            }
            else if stateLabel.text == "Use the honey for the bear, and it looks kind and nice after that. And you have found the signal guns inside the hole! (You win!)"
            {
                progressBar.value = 1;
            }
        case .glassAction:
            let index = arc4random()%UInt32(glassActions.count);
            stateLabel.text = (glassActions.object(at: Int(index)) as! String);
            if stateLabel.text == "here are some gears inside this grass, congregations! (+ 15% winning point)"
            {
                progressBar.value = progressBar.value + 0.15;
                glassActions.remove("here are some gears inside this grass, congregations! (+ 15% winning point)");
                userDefault.set(true, forKey: "GetForestWinKey1");
                userDefault.synchronize();
            }
            else if stateLabel.text ==  "There are some shafts inside the grass. (+10% winning point)"
            {
                progressBar.value = progressBar.value + 0.1;
                glassActions.remove("There are some shafts inside the grass. (+10% winning point)");
                userDefault.set(true, forKey: "GetForestWinKey2");
                userDefault.synchronize();
            }
        case .houseAction:
            let index = arc4random()%UInt32(houseActions.count);
            stateLabel.text = (houseActions.object(at: Int(index)) as! String);
            if stateLabel.text == "Find some bread inside this house. (HP+10%)"
            {
                healthBar.value = healthBar.value + 0.1;
            }
            else if stateLabel.text == "Go sleep inside this house. (HP+20%)"
            {
                healthBar.value = healthBar.value + 0.2;
            }
            else if stateLabel.text == "The house is so old which felling down makes you get hurt. (HP-20%)"
            {
                healthBar.value = healthBar.value - 0.2;
            }
        }
        
        self.checkDeathOrWin();
        actionCount = actionCount + 1;
    }
    
    func checkDeathOrWin() {
        
        let userDefault = UserDefaults.standard;
        
        if healthBar.value > 1{
            healthBar.value = 1;
        }
        
        if progressBar.value == 1 {
            
            if userActionType == ActionType.holeAction &&
                stateLabel.text == "Use the honey for the bear, and it looks kind and nice after that. And you have found the signal guns inside the hole! (You win!)"
            {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0)
                {
                    self.present((self.storyboard?.instantiateViewController(withIdentifier: "WinViewController"))!, animated: true, completion: nil);
                    let userDefault = UserDefaults.standard;
                    userDefault.set(0.0, forKey: "ProgressKey");
                    userDefault.set(1, forKey: "HealthPercentKey");
                    userDefault.synchronize();
                }
            }
            else
            {
                //Win
                self.present((self.storyboard?.instantiateViewController(withIdentifier: "WinViewController"))!, animated: true, completion: nil);
                let userDefault = UserDefaults.standard;
                userDefault.set(0.0, forKey: "ProgressKey");
                userDefault.set(1, forKey: "HealthPercentKey");
                userDefault.synchronize();
            }
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
