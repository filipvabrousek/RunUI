//
//  Bindables.swift
//  RunFun
//
//  Created by Filip Vabroušek on 03/07/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import Combine

class FeedFetcher: BindableObject {
    var willChange = PassthroughSubject<FeedFetcher, Never>()
    
    var races = [Story](){
        didSet {
            willChange.send(self)
        }
    }
    
    init(){
        guard let url = URL(string: "http://swimrunny.co/database.txt") else {return}
        
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
