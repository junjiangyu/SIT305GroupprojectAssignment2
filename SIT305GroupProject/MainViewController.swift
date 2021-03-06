//
//  MainViewController.swift
//  SIT305GroupProject
//
//  Created by JOHN YU on 4/5/18.
//  Copyright © 2018 SIT305. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var waysScrollView: UIScrollView!
    
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var healthBar: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        waysScrollView.contentSize = CGSize.init(width: 375 * 9, height: waysScrollView.frame.size.height);
        
        
        for i in 0...8 {
            let imageBtn = UIButton.init(frame: CGRect.init(x: i*375, y: 0, width: 375, height: Int(waysScrollView.frame.size.height)));
            
            imageBtn.setBackgroundImage(UIImage.init(named: "island.jpeg"), for: .normal);
            
            imageBtn.addTarget(self, action: #selector(waysClickAction(_:)), for: .touchUpInside);
            imageBtn.tag = i+1000;
            
            
            let label = UILabel.init(frame: CGRect.init(x: 15, y: 15, width: 345, height: 40));
            label.font = UIFont.systemFont(ofSize: 15);
            label.numberOfLines = 2;
            label.textColor = UIColor.cyan;
            if i == 0{
               imageBtn.setBackgroundImage(UIImage.init(named: "island.jpeg"), for: .normal);
            }
            else if i == 1{
                label.text = "So many trees inside this direction. Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "forest.jpg"), for: .normal);
            }else if i == 2{
                label.text = "Many sand inside this direction. Maybe this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "beach.jpg"), for: .normal);
            }else if i == 3{
                label.text = "Many containers inside this direction. Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "harbor.jpg"), for: .normal);
            }else if i == 4{
                label.text = "Looks like inside this direction got an abandon airport. Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "airport.jpg"), for: .normal);
            }else if i == 5{
                label.text = "Looks like a small wood house inside of there,Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "house.jpeg"), for: .normal);
            }
            else if i == 6{
                label.text = "Looks like a old church inside of there,Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "Old_Church.jpeg"), for: .normal);
            }
            else if i == 7{
                label.text = "Looks like a secret Ruin inside of there,Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "ruin.jpg"), for: .normal);
            }
            else if i == 8{
                label.text = "Looks like a secret School inside of there,Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "school.jpg"), for: .normal);
            }
            
            
            imageBtn.addSubview(label);
            
            
            waysScrollView.addSubview(imageBtn);
            
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
        
        let progress = userDefault.float(forKey: "ProgressKey");
        let health = userDefault.float(forKey: "HealthPercentKey");
        
        progressBar.value = progress;
        healthBar.value = health;
        
    }
    
    /// way choose click action
    ///
    /// - Parameter btn: Which way
    @objc func waysClickAction(_ btn:UIButton){
        
        //use button's tag to choose way.
        switch btn.tag {
        case 1001:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForestViewController")as! ForestViewController;
            self.present(vc, animated: true, completion: nil);
        case 1002:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeachViewController")as! BeachViewController;
            self.present(vc, animated: true, completion: nil);
        case 1003:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HarborViewController")as! HarborViewController;
            self.present(vc, animated: true, completion: nil);
        case 1004:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirportViewController")as! AirportViewController;
            self.present(vc, animated: true, completion: nil);
        case 1005:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseViewController")as! HouseViewController;
            self.present(vc, animated: true, completion: nil);
        case 1006:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChurchViewController")as! ChurchViewController;
            self.present(vc, animated: true, completion: nil);
        case 1007:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RuinViewController")as! RuinViewController;
            self.present(vc, animated: true, completion: nil);
        case 1008:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SchoolViewController")as! SchoolViewController;
            self.present(vc, animated: true, completion: nil);

            
            
        default:
            return;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
