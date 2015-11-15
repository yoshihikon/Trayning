//
//  SettingViewController
//  Trayning
//
//  Created by yoshihiko on 2015/11/11.
//  Copyright © 2015年 goodmix. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, TrayControllerDelegate {
    
    @IBOutlet weak var point0ValueLabel: UILabel!
    @IBOutlet weak var point1ValueLabel: UILabel!
    @IBOutlet weak var point2ValueLabel: UILabel!
    
    @IBOutlet weak var point0SensivityLabel: UILabel!
    @IBOutlet weak var point1SensivityLabel: UILabel!
    @IBOutlet weak var point2SensivityLabel: UILabel!
    
    @IBOutlet weak var point0SensivitySlider: UISlider!
    @IBOutlet weak var point1SensivitySlider: UISlider!
    @IBOutlet weak var point2SensivitySlider: UISlider!
    
    @IBOutlet weak var pointIntervalValueLabel: UILabel!
    @IBOutlet weak var pointIntervalSlider: UISlider!
    
    @IBOutlet weak var noEatIntervalValueLabel: UILabel!
    @IBOutlet weak var noEatIntervalSlider: UISlider!
    
    var point0Value: Float!
    var point1Value: Float!
    var point2Value: Float!
    
    var point0SensivityValue: Float!
    var point1SensivityValue: Float!
    var point2SensivityValue: Float!
    
    var pointIntervalValue: Int!
    var noEatIntervalValue: Int!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //user defaults
        point0SensivityValue = userDefaults.floatForKey("point0Sensivity")
        point1SensivityValue = userDefaults.floatForKey("point1Sensivity")
        point2SensivityValue = userDefaults.floatForKey("point2Sensivity")
        pointIntervalValue = userDefaults.integerForKey("pointInterval")
        noEatIntervalValue = userDefaults.integerForKey("noEatInterval")
        
        //SensivitySlider
        point0SensivitySlider.minimumValue = TrayController.shared.sensivityMinimunValue
        point0SensivitySlider.maximumValue = TrayController.shared.sensivityMaximumValue
        point1SensivitySlider.minimumValue = TrayController.shared.sensivityMinimunValue
        point1SensivitySlider.maximumValue = TrayController.shared.sensivityMaximumValue
        point2SensivitySlider.minimumValue = TrayController.shared.sensivityMinimunValue
        point2SensivitySlider.maximumValue = TrayController.shared.sensivityMaximumValue
        
        point0SensivitySlider.value = point0SensivityValue
        point1SensivitySlider.value = point1SensivityValue
        point2SensivitySlider.value = point2SensivityValue
        
        point0SensivityLabel.text = String(point0SensivityValue)
        point1SensivityLabel.text = String(point1SensivityValue)
        point2SensivityLabel.text = String(point2SensivityValue)
        
        //Point Interval
        pointIntervalSlider.value = Float(pointIntervalValue)
        pointIntervalValueLabel.text = String(pointIntervalValue) + "sec"
        
        //No Eat Interval
        noEatIntervalSlider.value = Float(noEatIntervalValue)
        noEatIntervalValueLabel.text = String(noEatIntervalValue) + "sec"
        
        //Delegate
        TrayController.shared.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        //Delegate
        TrayController.shared.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    @IBAction func changePoint0Sensivity(sender:UISlider) {
        point0SensivityValue = sender.value
        point0SensivityLabel.text = String(point0SensivityValue)
        userDefaults.setFloat(point0SensivityValue, forKey: "point0Sensivity")
        
        TrayController.shared.refreshSensivity()
    }
    
    @IBAction func tapPoint0LightA() {
        TrayController.shared.lightOn0A()
    }
    
    @IBAction func tapPoint0LightB() {
        TrayController.shared.lightOn0B()
    }
    
    @IBAction func changePoint1Sensivity(sender:UISlider) {
        point1SensivityValue = sender.value
        point1SensivityLabel.text = String(point1SensivityValue)
        userDefaults.setFloat(point1SensivityValue, forKey: "point1Sensivity")
        
        TrayController.shared.refreshSensivity()
    }
    
    @IBAction func tapPoint1LightA() {
        TrayController.shared.lightOn1A()
    }
    
    @IBAction func tapPoint1LightB() {
        TrayController.shared.lightOn1B()
    }
    
    @IBAction func changePoint2Sensivity(sender:UISlider) {
        point2SensivityValue = sender.value
        point2SensivityLabel.text = String(point2SensivityValue)
        userDefaults.setFloat(point2SensivityValue, forKey: "point2Sensivity")
        
        TrayController.shared.refreshSensivity()
    }
    
    @IBAction func tapPoint2LightA() {
        TrayController.shared.lightOn2A()
    }
    
    @IBAction func tapPoint2LightB() {
        TrayController.shared.lightOn2B()
    }
    
    @IBAction func changePointInterval(sender:UISlider) {
        pointIntervalValue = Int(sender.value)
        pointIntervalValueLabel.text = String(pointIntervalValue) + "sec"
        userDefaults.setInteger(pointIntervalValue, forKey: "pointInterval")
    }
    
    @IBAction func changeNoEatInterval(sender:UISlider) {
        noEatIntervalValue = Int(sender.value)
        noEatIntervalValueLabel.text = String(noEatIntervalValue) + "sec"
        userDefaults.setInteger(noEatIntervalValue, forKey: "noEatInterval")
    }
    
    // MARK: - TrayControlelrDelegate
    func isReady() {
    }
    
    func updatePoint0(value:Float) {
        point0ValueLabel.text = String(value)
    }
    
    func updatePoint1(value:Float) {
        point1ValueLabel.text = String(value)
    }
    
    func updatePoint2(value:Float) {
        point2ValueLabel.text = String(value)
    }
    
    func updateMostActivePoint(point: Int) {
        
    }
}

