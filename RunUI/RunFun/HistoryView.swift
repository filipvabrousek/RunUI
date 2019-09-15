//
//  HistoryView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 30/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import Combine
import CoreData
import CoreLocation


class FV: ObservableObject {
    let f = Fetcher(ename: "Activities", key: "runs")

    @Published
    var runs = [Run]()

    func fetch() {
        self.runs = f.fetchR()
    }
    
}

struct DetailView: View {
    @EnvironmentObject var manager: FV
    @State var on = true
    @State var mapped = [RunVM]()

    var body: some View {
        NavigationView { // or Presentation button
            VStack {
                List {
                    ForEach(manager.runs.reversed(), id: \.self) { run in
                        RunCell(runvm: RunVM(run: run))
                    }.onDelete(perform: delete)
                }
            }.navigationBarTitle("Runs")
        }
            .onAppear {
                self.manager.fetch()
        }
    }

    func delete(at offsets: IndexSet) {
        guard let index = Array(offsets).first else { return }
        manager.runs.remove(at: manager.runs.count - index)
    }
}


// https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-new-view-using-presentationbutton

struct RunCell: View {

    var runvm: RunVM

    var body: some View {
        NavigationLink(destination: RunDetail(run: runvm)) {
            HStack {
                Map(loc2d: CLLocationCoordinate2D(latitude: runvm.lastLAT, longitude: runvm.lastLON)).frame(width: 60, height: 60)
                Spacer()
                Text("Cupertino").font(.system(size: 20)).bold()
                Spacer()
                // Rectangle().frame(width: 60, height: 60).foregroundColor(Color(0x1abc9c))
                VStack(alignment: .leading) {
                    Text(runvm.dist).font(.system(size: 20)).bold()
                    Text(runvm.time)
                }
                Spacer()
            }.navigationBarTitle(Text("Runs"))
        }
        // PresentationButton(Text("Show"), destination: RunDetail(run: run)) - WEIRD STYLE
    }
}


class RunVM {
    var run: Run

    init(run: Run) {
        self.run = run
    }

    var dist: String {
        let meters = self.run.dist / 1000
        let dist = round(meters * 100) / 100.0
        return "\(dist)"
    }

    var time: String {
        return run.time
    }

    var latpoints: [Double] {
        return run.latPoints
    }

    var lonPoints: [Double] {
        return run.lonPoints
    }

    var lastLAT: Double {
        return run.latPoints.last!
    }

    var lastLON: Double {
        return run.lonPoints.last!
    }

}
