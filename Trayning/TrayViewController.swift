//
//  TrayViewController.swift
//  Trayning
//
//  Created by yoshihiko on 2015/11/14.
//  Copyright © 2015年 goodmix. All rights reserved.
//

import UIKit

class TrayViewController: UIViewController, TrayControllerDelegate {
    
    @IBOutlet weak var letsEatButton: UIButton!
    @IBOutlet weak var goodJobButton: UIButton!
    @IBOutlet weak var retrayButton: UIButton!
    
    @IBOutlet weak var point0LightAImage: LightView!
    //@IBOutlet weak var point0LightBImage: UIImageView!
    @IBOutlet weak var point1LightAImage: LightView!
    //@IBOutlet weak var point1LightBImage: UIImageView!
    @IBOutlet weak var point2LightAImage: LightView!
    //@IBOutlet weak var point2LightBImage: UIImageView!
    
    //value
    var point0Value: Float!
    var point1Value: Float!
    var point2Value: Float!
    
    var point0SensivityValue: Float!
    var point1SensivityValue: Float!
    var point2SensivityValue: Float!
    
    var pointIntervalValue: Int!
    var noEatIntervalValue: Int!
    
    var lightDuration: Double = 2.0
    
    var point0EatCount: Int = 0
    var point1EatCount: Int = 0
    var point2EatCount: Int = 0
    
    //timer
    var nextEatTimer: NSTimer!
    
    var light0Timer: NSTimer!
    var light1Timer: NSTimer!
    var light2Timer: NSTimer!
    
    var checkNoEatTimer: NSTimer!
    
    //flag
    var isTraining: Bool!
    var isSetNextEatTimer: Bool = false
    
    //user defaults
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isTraining = false
        
        //user defaults
        point0SensivityValue = userDefaults.floatForKey("point0Sensivity")
        point1SensivityValue = userDefaults.floatForKey("point1Sensivity")
        point2SensivityValue = userDefaults.floatForKey("point2Sensivity")
        pointIntervalValue = userDefaults.integerForKey("pointInterval")
        noEatIntervalValue = userDefaults.integerForKey("noEatInterval")
        
        //image
        point0LightAImage.hide()
        //point0LightBImage.hide()
        point1LightAImage.hide()
        //point1LightBImage.hide()
        point2LightAImage.hide()
        //point2LightBImage.hide()
        
        //button
        letsEatButton.hidden = false
        goodJobButton.hidden = true
        retrayButton.hidden = true
        
        //delegate
        TrayController.shared.delegate = self;
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        if isTraining == true {
            tabRetray()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //user defaults
        point0SensivityValue = userDefaults.floatForKey("point0Sensivity")
        point1SensivityValue = userDefaults.floatForKey("point1Sensivity")
        point2SensivityValue = userDefaults.floatForKey("point2Sensivity")
        pointIntervalValue = userDefaults.integerForKey("pointInterval")
        noEatIntervalValue = userDefaults.integerForKey("noEatInterval")
        
        //delegate
        TrayController.shared.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    @IBAction func tapLetsEat(){
        
        isTraining = true
        
        letsEatButton.hidden = true
        goodJobButton.hidden = false
        retrayButton.hidden = false
        
        TrayController.shared.startCheckMostActivePoint()
        
        checkNoEatTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("checkNoEat"), userInfo: nil, repeats: true)
    }
    @IBAction func tapGoodJob(){
        
        isTraining = false
        
        letsEatButton.hidden = false
        goodJobButton.hidden = true
        retrayButton.hidden = true
        
        TrayController.shared.stopCheckMostActivePoint()
        
        if checkNoEatTimer.valid == true {
            checkNoEatTimer.invalidate()
        }
    }
    @IBAction func tabRetray(){
        
        isTraining = false
        
        letsEatButton.hidden = false
        goodJobButton.hidden = true
        retrayButton.hidden = true
        
        TrayController.shared.stopCheckMostActivePoint()
        
        if checkNoEatTimer.valid == true {
            checkNoEatTimer.invalidate()
        }
    }
    
    // MARK: - TrayViewController Method
    
    //check no eat
    func checkNoEat(){
        point0EatCount += 1
        point1EatCount += 1
        point2EatCount += 1
        
        if point0EatCount >= noEatIntervalValue {
            lightOn0B()
        }
        
        if point1EatCount >= noEatIntervalValue {
            lightOn1B()
        }
        
        if point2EatCount >= noEatIntervalValue {
            lightOn2B()
        }
    }
    
    //light
    func lightOn0A() {
        print("TrayController: Light on [Point0 LightA]")
        
        if isSetNextEatTimer == true{
            nextEatTimer.invalidate()
        }
        
        nextEatTimer = NSTimer.scheduledTimerWithTimeInterval(Double(pointIntervalValue), target: self, selector: Selector("onOtherPoints0"), userInfo: nil, repeats: false)
        
        isSetNextEatTimer = true
        
        point0LightAImage.fadeIn()
        point1LightAImage.fadeOut()
        point2LightAImage.fadeOut()
        
        point0EatCount = 0
    }
    func lightOff0A() {
        print("TrayViewController: Light off [Point0 LightA]")
        
        point0LightAImage.fadeOut()
    }
    func lightOn0B() {
        print("TrayViewController: Light on [Point0 LightB]")
        
        light0Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff0B"), userInfo: nil, repeats: false)
        
        point0EatCount = 0
    }
    func lightOff0B() {
        print("TrayViewController: Light off [Point0 LightB]")
    }
    func lightOn1A() {
        print("TrayViewController: Light on [Point1 LightA]")
        
        if isSetNextEatTimer == true{
            nextEatTimer.invalidate()
        }
        
        nextEatTimer = NSTimer.scheduledTimerWithTimeInterval(Double(pointIntervalValue), target: self, selector: Selector("onOtherPoints1"), userInfo: nil, repeats: false)
        
        isSetNextEatTimer = true
        
        point0LightAImage.fadeOut()
        point1LightAImage.fadeIn()
        point2LightAImage.fadeOut()
        
        point1EatCount = 0
    }
    func lightOff1A() {
        print("TrayViewController: Light off [Point1 LightA]")
        
        point1LightAImage.fadeOut()
    }
    func lightOn1B() {
        print("TrayViewController: Light on [Point1 LightB]")
        
        light1Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff1B"), userInfo: nil, repeats: false)
        
        point1EatCount = 0
    }
    func lightOff1B() {
        print("TrayViewController: Light off [Point1 LightB]")
    }
    func lightOn2A() {
        print("TrayViewController: Light on [Point2 LightA]")
        
        if isSetNextEatTimer == true{
            nextEatTimer.invalidate()
        }
        
        nextEatTimer = NSTimer.scheduledTimerWithTimeInterval(Double(pointIntervalValue), target: self, selector: Selector("onOtherPoints2"), userInfo: nil, repeats: false)
        
        isSetNextEatTimer = true
        
        point0LightAImage.fadeOut()
        point1LightAImage.fadeOut()
        point2LightAImage.fadeIn()
        
        point2EatCount = 0
    }
    func lightOff2A() {
        print("TrayViewController: Light off [Point2 LightA]")
        
        point2LightAImage.fadeOut()
    }
    func lightOn2B() {
        print("TrayViewController: Light on [Point2 LightB]")
        
        light2Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff2B"), userInfo: nil, repeats: false)
        
        point2EatCount = 0
    }
    func lightOff2B() {
        print("TrayViewController: Light off [Point2 LightB]")
    }
    
    func onOtherPoints0(){
        
        isSetNextEatTimer = false
        
        TrayController.shared.lightOn1A()
        TrayController.shared.lightOn2A()
        
        light1Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff1A"), userInfo: nil, repeats: false)
        light2Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff2A"), userInfo: nil, repeats: false)
        
        point0LightAImage.fadeOut()
        point1LightAImage.fadeIn()
        point2LightAImage.fadeIn()
    }
    
    func onOtherPoints1(){
        
        isSetNextEatTimer = false
        
        TrayController.shared.lightOn0A()
        TrayController.shared.lightOn2A()
        
        light0Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff0A"), userInfo: nil, repeats: false)
        light2Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff2A"), userInfo: nil, repeats: false)
        
        point0LightAImage.fadeIn()
        point1LightAImage.fadeOut()
        point2LightAImage.fadeIn()
    }
    
    func onOtherPoints2(){
        
        isSetNextEatTimer = false
        
        TrayController.shared.lightOn0A()
        TrayController.shared.lightOn1A()
        
        light0Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff0A"), userInfo: nil, repeats: false)
        light1Timer = NSTimer.scheduledTimerWithTimeInterval(lightDuration, target: self, selector: Selector("lightOff1A"), userInfo: nil, repeats: false)
        
        point0LightAImage.fadeIn()
        point1LightAImage.fadeIn()
        point2LightAImage.fadeOut()
    }
    
    func lightOffAll() {
        lightOff0A()
        lightOff0B()
        lightOff1A()
        lightOff1B()
        lightOff2A()
        lightOff2B()
    }
    

    // MARK: - TrayControlelrDelegate
    func isReady() {
    }
    
    func updatePoint0(value:Float) {
    }
    
    func updatePoint1(value:Float) {
    }
    
    func updatePoint2(value:Float) {
    }

    func updateMostActivePoint(point: Int) {
        
        if isTraining == true {
            switch point {
            case 0:
                lightOn0A()
                break;
            case 1:
                lightOn1A()
                break;
            case 2:
                lightOn2A()
                break;
            default:
                break;
            }
        }
        
    }
}
