//
//  ContentView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 12/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine
import CoreData
import CoreGraphics


struct ActivityView: View {
    @State var manager = SLM(start: CLLocation(latitude: 0.0, longitude: 0.0))
    @State var rm = FV()
    @State var duration = 0
    @State var formatted = ""
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            self.duration += 1
            
            let t = Time(seconds: self.duration)
            self.formatted = t.createTime
        }
    }
    
    var body: some View {
        VStack {
            Text("RunUI").font(.title).bold().padding(.bottom, 10)
            
            HStack {
                
                VStack {
                    Text("\(manager.distance / 1000)".prefix(4)).font(.system(size: 30)).bold()
                    Text("Distance").font(.system(size: 19)).bold()
                }
                
                Spacer()
                VStack {
                    Text("\(formatted)").font(.system(size: 30)).bold()
                        .onAppear(perform: {_ = self.timer})
                    Text("Duration").font(.system(size: 19)).bold()
                }
                
            }.padding(.trailing, 80)
             .padding(.leading, 80)
            
            
            ZStack(alignment: .bottomLeading) {
                MapView(loc2D: CLLocationCoordinate2D(latitude: manager.lastLoc.coordinate.latitude, longitude: manager.lastLoc.coordinate.longitude))
                
                Button("Save"){
                    let m = self.manager
                    let run = Run(dist: m.distance, time: self.formatted, latPoints: m.latpoints, lonPoints: m.lonpoints)
                    let s = Saver(ename: "Activities", key: "runs", obj: run)
                    s.save()
                }
                    
                    .padding()
                    .font(Font.body.bold())
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .offset(x: 290, y: -10)
                //.offset(x: 90, y: 200)
            }
            
            
            
        }
    }
}





// https://stackoverflow.com/questions/56553527/show-user-location-on-map-swiftui


class SLM: NSObject, CLLocationManagerDelegate, BindableObject {
    private var manager = CLLocationManager()
    var willChange = PassthroughSubject<SLM, Never>()
    
    var lastLoc: CLLocation {
        didSet {
            willChange.send(self)
        }
    }
    
    var firstLoc: CLLocation {
        didSet {
            willChange.send(self)
        }
    }
    
    var distance: Double {
        didSet {
            willChange.send(self)
        }
    }
    
    var latpoints: [Double]{
        didSet {
            willChange.send(self)
        }
    }
    
    
    var lonpoints: [Double]{
        didSet {
            willChange.send(self)
        }
    }
    
    
    var start: CLLocation
    
    init(manager: CLLocationManager = CLLocationManager(), start: CLLocation){
        self.start = start
        self.manager = manager
        self.lastLoc = CLLocation(latitude: 0.0, longitude: 0.0)
        self.firstLoc = CLLocation(latitude: 0.0, longitude: 0.0)
        self.latpoints = [Double]()
        self.lonpoints = [Double]()
        self.distance = 0.0
        super.init()
        self.startUpdate()
    }
    
    
    func startUpdate(){
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            
            // let rand = Int.random(in: 1000...100000)
            
            if let val = UserDefaults.standard.value(forKey: "done") as? String {
                if val == "NO" { // set to NO in SceneDelegate
                    firstLoc = locations.last!
                    UserDefaults.standard.set("YES", forKey: "done")
                }
            }
            
            lastLoc = locations.last!
            distance = locations.last!.distance(from: firstLoc) // from: start
            
            latpoints.append(lastLoc.coordinate.latitude)
            lonpoints.append(lastLoc.coordinate.longitude)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}



struct MapView: UIViewRepresentable {
    var loc2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    init(loc2D: CLLocationCoordinate2D){
        self.loc2D = loc2D
    }
    
    var LM: CLLocationManager = {
        let lm = CLLocationManager()
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestAlwaysAuthorization()
        return lm
    }()
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
        // MKMapView(frame: .zero)
        
        let map: MKMapView = {
            let map = MKMapView()
            map.showsUserLocation = true
            // user tracing mode
            return map
        }()
        
        return map
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
        let coord = LM.location?.coordinate
        
        if coord != nil {
            let coord = CLLocationCoordinate2D(latitude: loc2D.latitude, longitude: loc2D.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007) // 0.005
            let region = MKCoordinateRegion(center: coord, span: span)
            view.setRegion(region, animated: false)
        }
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
