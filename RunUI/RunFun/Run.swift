//
//  Run.swift
//  RunFun
//
//  Created by Filip Vabroušek on 29/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit
import SwiftUI

class Run: NSObject, NSCoding, Identifiable {
    
    struct Keys {
        static let dist = "dist"
        static let time = "time"
        static let latPoints = "latPoints"
        static let lonPoints = "lonPoints"
    }
    
    private var _dist = 0.0
    private var _time = ""
    private var _latPoints = [Double]()
    private var _lonPoints = [Double]()
    
    override init() {}
    
    // http://blog.human-friendly.com/swiftui-core-data-and-combine-early-days
    init(dist: Double, time: String, latPoints: [Double], lonPoints: [Double]){
        self._dist = dist
        self._time = time
        self._latPoints = latPoints
        self._lonPoints = lonPoints
    }
    
    required init?(coder: NSCoder) {
        if let DO = coder.decodeDouble(forKey: Keys.dist) as? Double {
            _dist = DO
        }
        
        if let time = coder.decodeObject(forKey: Keys.time) as? String {
            _time = time
        }
        
        if let LATP = coder.decodeObject(forKey: Keys.latPoints) as? [Double]{
            _latPoints = LATP
        }
        
        if let LONP = coder.decodeObject(forKey: Keys.lonPoints) as? [Double]{
            _lonPoints = LONP
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(_dist, forKey: Keys.dist)
        coder.encode(_time, forKey: Keys.time)
        coder.encode(_latPoints, forKey: Keys.latPoints)
        coder.encode(_lonPoints, forKey: Keys.lonPoints)
    }
    
    var dist: Double {
        get {
            return _dist
        }
        
        set {
            _dist = newValue
        }
    }
    
    var time: String {
        get {
           return _time
        }
        
        set {
           _time = newValue
        }
    }
    
    
    var latPoints:[Double]{
        get{
            return _latPoints
        }
        
        set{
            _latPoints = newValue
        }
    }
    
    
    var lonPoints:[Double]{
        get{
            return _lonPoints
            
        }
        
        set{
            _lonPoints = newValue
        }
    }
}




class Time {
    var seconds = 0
    init(seconds: Int) {
        self.seconds = seconds
    }
    
    var createTime:String{
        let time =  (seconds / 3600, (seconds % 3600) / 60, seconds % 60)
        let (_, m, s) = time
        
     //   var strHr = String(h)
        var strMin = String(m)
        var strSec = String(s)
        
        if m < 10{
            strMin = "0\(m)"
        }
        
        if s < 10{
            strSec = "0\(s)"
        }
        
        return "\(strMin):\(strSec)"
    }
}



