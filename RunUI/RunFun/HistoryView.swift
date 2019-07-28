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

// How to reload this automatically


/*
 
class FV: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    let l = Fetcher(ename: "Activities", key: "runs")
    
    
    var runs: [Run] = []{
        didSet{
            didChange.send(())
        }
    }
    
    init() {
        fetch()
    }
    
    // init
    func fetch() {
        let data = l.fetchR()
        self.runs = data
    }
}*/



/*
 
class FV: NSObject,BindableObject, NSFetchedResultsControllerDelegate {
    var didChange = PassthroughSubject<FV, Never>()
    var runs = [Run]()
    var controller = NSFetchedResultsController<NSFetchRequestResult>()
    
    override init(){
        super.init()
        controller.delegate = self
        do {
            try controller.performFetch()
        }
        
        catch {
            print("FAILED TO FETCH")
            print(error)
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let f = Fetcher(ename: "Activities", key: "runs")
        self.runs = f.fetchR()
        didChange.send(self)
    }
}*/




class FV: BindableObject {
    var willChange = PassthroughSubject<Void, Never>()
    let f = Fetcher(ename: "Activities", key: "runs")
    var runs = [Run]() {
        didSet {
            willChange.send(())
        }
    }

    func fetch() {
        self.runs = f.fetchR()
    }
}



struct DetailView: View {
    @State var manager = FV()
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

                // return List(self.manager.runs.map { RunVM(run: $0) }.reversed(), id: \.dist, rowContent: RunCell.init)
            }
        } .navigationBarTitle(Text("Runs"))
            .onAppear(perform: {
                self.manager.fetch()
            })
    }

    func delete(at offsets: IndexSet) {
        guard let index = Array(offsets).first else { return }
        manager.runs.remove(at: manager.runs.count - index)
    }
}


// https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-new-view-using-presentationbutton

struct RunCell: View {
    // var run: Run
    var runvm: RunVM

    var body: some View {
        NavigationLink(destination: RunDetail(run: runvm)) {
            HStack {
                Rectangle().frame(width: 60, height: 60).foregroundColor(Color(0x1abc9c))
                VStack(alignment: .leading) {
                    Text(runvm.dist).font(.system(size: 20)).bold()
                    Text(runvm.time)
                }
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
