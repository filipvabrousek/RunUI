//
//  Bindables.swift
//  RunFun
//
//  Created by Filip Vabroušek on 03/07/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import Combine

class FeedFetcher: ObservableObject {
    
    @Published
    var races = [Story]()
    
    
    init(){
        guard let url = URL(string: "http://www.swimrunworld.co/database.txt") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            // let races = try! JSONDecoder().decode([String].self, from: data)
            
            do {
                let races = try String(contentsOf: url)
                
                let arr = races.components(separatedBy: .newlines)
                var res = [Story]()
                
                for x in arr {
                    res.append(Story(name: x, image: "first"))
                }
                
                DispatchQueue.main.async {
                    self.races = res
                }
            }
                
            catch {}
            }.resume()
    }
}
