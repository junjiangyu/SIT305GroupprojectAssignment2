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
        
        waysScrollView.contentSize = CGSize.init(width: 375 * 4, height: waysScrollView.frame.size.height);
        
        
        for i in 0...3 {
            let imageBtn = UIButton.init(frame: CGRect.init(x: i*375, y: 0, width: 375, height: Int(waysScrollView.frame.size.height)));
            
            imageBtn.setBackgroundImage(UIImage.init(named: "island.jpeg"), for: .normal);
            
            imageBtn.addTarget(self, action: #selector(waysClickAction(_:)), for: .touchUpInside);
            imageBtn.tag = i+1000;
            
            
            let label = UILabel.init(frame: CGRect.init(x: 15, y: 15, width: 345, height: 40));
            label.font = UIFont.systemFont(ofSize: 15);
            label.numberOfLines = 2;
            label.textColor = UIColor.cyan;
            if i == 0{
                label.text = "So many trees inside this direction. Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "forest.jpg"), for: .normal);
            }else if i == 1{
                label.text = "Many sand inside this direction. Maybe this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "beach.jpg"), for: .normal);
            }else if i == 2{
                label.text = "Many containers inside this direction. Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "harbor.jpg"), for: .normal);
            }else{
                label.text = "Looks like inside this direction got an abandon airport. Go this way?";
                imageBtn.setBackgroundImage(UIImage.init(named: "airport.jpg"), for: .normal);
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
        case 1000:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForestViewController")as! ForestViewController;
            self.present(vc, animated: true, completion: nil);
        case 1001:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeachViewController")as! BeachViewController;
            self.present(vc, animated: true, completion: nil);
        case 1002:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HarborViewController")as! HarborViewController;
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
