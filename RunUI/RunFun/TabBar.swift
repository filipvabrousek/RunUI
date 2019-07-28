//
//  ActivityView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 13/07/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        TabbedView {
            ActivityView().tabItem {Image("envelope"); Text("Run")}.tag(0)
            DetailView().tabItem {Image("envelope"); Text("Runs")}.tag(1)
            FeedView().tabItem {Image("envelope"); Text("Feed")}.tag(2)
            CadenceView().tabItem {Image("envelope"); Text("Cadence")}.tag(3)
        }
        .onAppear(perform: {UserDefaults.standard.set("NO", forKey: "done")})
    }
}
