//
//  TrayController.swift
//  Trayning
//
//  Created by yoshihiko on 2015/11/15.
//  Copyright © 2015年 goodmix. All rights reserved.
//

import UIKit

protocol TrayControllerDelegate: class {
    func isReady()
    
    func updatePoint0(value:Float)
    func updatePoint1(value:Float)
    func updatePoint2(value:Float)
    
    func updateMostActivePoint(point:Int)
}

class TrayController: NSObject {
    
    //singleton
    static let shared = TrayController()
    
    //delegate
    weak var delegate: TrayControllerDelegate? = nil
    
    //value
    let sensivityMinimunValue:Float = 0.0;
    let sensivityMaximumValue:Float = 1.29;
    
    var point0Value: Float!
    var point1Value: Float!
    var point2Value: Float!
    
    var point0SensivityValue: Float!
    var point1SensivityValue: Float!
    var point2SensivityValue: Float!
    
    var point0LatestValue: Float! = 0.0
    var point1LatestValue: Float! = 0.0
    var point2LatestValue: Float! = 0.0
    
    var point0DiffValue: Float! = 0.0
    var point1DiffValue: Float! = 0.0
    var point2DiffValue: Float! = 0.0
    
    //timer
    var requestTimer: NSTimer!
    
    var checkMostActivePointTimer: NSTimer!
    
    //flag
    var isSetLight0Timer: Bool = false
    var isSetLight1Timer: Bool = false
    var isSetLight2Timer: Bool = false
    
    //user defaults
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: - TrayController method
    
    
    func ready() {
        //user defaults
        point0SensivityValue = userDefaults.floatForKey("point0Sensivity")
        point1SensivityValue = userDefaults.floatForKey("point1Sensivity")
        point2SensivityValue = userDefaults.floatForKey("point2Sensivity")
        
        //event handler
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "konashiReady", name: KonashiEventReadyToUseNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "point0Update", name: KonashiEventAnalogIO0DidUpdateNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "point1Update", name: KonashiEventAnalogIO1DidUpdateNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "point2Update", name: KonashiEventAnalogIO2DidUpdateNotification, object: nil)
    }
    
    func refreshSensivity() {
        //user defaults
        point0SensivityValue = userDefaults.floatForKey("point0Sensivity")
        point1SensivityValue = userDefaults.floatForKey("point1Sensivity")
        point2SensivityValue = userDefaults.floatForKey("point2Sensivity")
    }
    
    //control konashi
    func connect() {
        
        //Konashi.find()
        
        Konashi.findWithName("konashi#4-1787")
    }
    
    func requestTray() {
        Konashi.analogReadRequest(KonashiAnalogIOPin.IO0)
        Konashi.analogReadRequest(KonashiAnalogIOPin.IO1)
        Konashi.analogReadRequest(KonashiAnalogIOPin.IO2)
    }
    
    //most active point
    func startCheckMostActivePoint() {
        print("TrayController: start check most active point")
        
        checkMostActivePointTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("checkMostActivePoint"), userInfo: nil, repeats: true)
    }
    
    func stopCheckMostActivePoint() {
        print("TrayController: stop check most active point")
        
        if checkMostActivePointTimer.valid == true {
            checkMostActivePointTimer.invalidate()
        }
    }
    
    func checkMostActivePoint() {
        let maxValue:Float = max(point0DiffValue, point1DiffValue, point2DiffValue)
        
        if maxValue > 0.0 && maxValue < 1.28 {
            
            switch maxValue {
            case point0DiffValue:
                
                print("TrayController: most active is 0:\(point0DiffValue)")
                
                delegate?.updateMostActivePoint(0)
                
                break
            case point1DiffValue:
                
                print("TrayController: most active is 1:\(point1DiffValue)")
                
                delegate?.updateMostActivePoint(1)
                
                break
            case point2DiffValue:
                
                print("TrayController: most active is 2:\(point2DiffValue)")
                
                delegate?.updateMostActivePoint(2)
                
                break
            default:
                break
            }
            
        }
        
        point0DiffValue = 0.0;
        point1DiffValue = 0.0;
        point2DiffValue = 0.0;
    }
    
    //control light
    func lightOn0A() {
        print("TrayController: Light on [Point0 LightA]")
    }
    func lightOff0A() {
        print("TrayController: Light off [Point0 LightA]")
    }
    func lightOn0B() {
        print("TrayController: Light on [Point0 LightB]")
    }
    func lightOff0B() {
        print("TrayController: Light off [Point0 LightB]")
    }
    func lightOn1A() {
        print("TrayController: Light on [Point1 LightA]")
    }
    func lightOff1A() {
        print("TrayController: Light off [Point1 LightA]")
    }
    func lightOn1B() {
        print("TrayController: Light on [Point1 LightB]")
    }
    func lightOff1B() {
        print("TrayController: Light off [Point1 LightB]")
    }
    func lightOn2A() {
        print("TrayController: Light on [Point2 LightA]")
    }
    func lightOff2A() {
        print("TrayController: Light off [Point2 LightA]")
    }
    func lightOn2B() {
        print("TrayController: Light on [Point2 LightB]")
    }
    func lightOff2B() {
        print("TrayController: Light off [Point2 LightB]")
    }
    
    func lightOffAll() {
        lightOff0A()
        lightOff0B()
        lightOff1A()
        lightOff1B()
        lightOff2A()
        lightOff2B()
    }
    
    // MARK: - Konashi Handler
    func konashiReady() {
        print("konashi ready\n")
        
        delegate?.isReady()
        
        Konashi.pinMode(KonashiDigitalIOPin.LED2, mode: KonashiPinMode.Output)
        Konashi.digitalWrite(KonashiDigitalIOPin.LED2, value: KonashiLevel.High)
        
        requestTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("requestTray"), userInfo: nil, repeats: true)
    }
    
    func point0Update() {
        let value:Float = Float(Konashi.analogRead(KonashiAnalogIOPin.IO0)) / 1000;
        
        delegate?.updatePoint0(value)
        
        let diff = abs(value - point0LatestValue)
        
        if diff > point0SensivityValue{
            point0DiffValue = point0DiffValue + diff
        }
        
        point0LatestValue = value
    }
    
    func point1Update() {
        let value:Float = Float(Konashi.analogRead(KonashiAnalogIOPin.IO1)) / 1000;
        
        delegate?.updatePoint1(value)
        
        let diff = abs(value - point1LatestValue)
        
        if diff > point1SensivityValue{
            point1DiffValue = point1DiffValue + diff
        }
        
        point1LatestValue = value
    }
    
    func point2Update() {
        let value:Float = Float(Konashi.analogRead(KonashiAnalogIOPin.IO2)) / 1000;
        
        delegate?.updatePoint2(value)
        
        let diff = abs(value - point2LatestValue)
        
        if diff > point2SensivityValue{
            point2DiffValue = point2DiffValue + diff
        }
        
        point2LatestValue = value
    }
}
