//
//  FeedView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 29/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import Combine


struct FeedView : View {
    
    let posts = [
        Post(heading: "Filip Vabroušek", text: "At the race I managed to win overall. The course led through some really though boulders... ", likes: 13200, image: "first", ago: "24 seconds ago"),
        Post(heading: "Petr Vabroušek", text: "1st place Oravaman: I lead the pack during the first 5k and then I took the first place overall, while smashing my PB of 32:30", likes: 4200, image: "second", ago: "1 minute ago"),
        Post(heading: "Tereza", text: "Today I flew to Balkan on my Vacation and it went great!!", likes: 2400, image: "third", ago: "6 minutes ago")
    ]
    
    
    @State var fetcher = FeedFetcher()
    
    var body: some View {
        VStack {
            Text("Feed").font(.system(size: 30)).bold()
            Text("Data below are fetched from a website.").foregroundColor(.gray)
            
            List {
                StoryView().frame(height: 100)
                
               /* ForEach(posts.identified(by: \.heading)){ post in
                    PostCell(post: post)
                }*/
                ForEach(posts, id: \.heading) { p in
                     PostCell(post: p)
                }
            }
        }
    }
}





struct PostCell: View {
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("third").resizable().frame(width: 30, height: 30).clipShape(Circle())
                Text(post.heading).fontWeight(.bold)
                }.frame(height: 40)
            
            Image(post.image).resizable().scaledToFit()
            /*  Image(post.image)
             .resizable()
             .scaledToFill()*/
            
            
            VStack(alignment: .leading) {
                
                
                
                HStack {
                    HStack {
                        Image(systemName: "heart")
                        Spacer()
                        Image(systemName: "message")
                        Spacer()
                        Image(systemName: "triangle")
                        }.padding(.leading, 6).frame(width: 80, height: 22)
                    
                    Spacer()
                    Image(systemName: "sun.min.fill")
                    }.frame(height: 40)
                
                Text("\(post.likes) likes").bold()
            }
            
            
            VStack(alignment: .leading) {
                Text(post.text).font(.system(.body)).lineLimit(nil)
                Text(post.ago).font(.system(.body)).foregroundColor(Color.gray).font(.system(size: 12))
                
            }
            
            
        }
    }
}



struct StoryView: View {
    @State var manager = FeedFetcher()
    
    var body: some View {
        ScrollView {
            HStack {
                ForEach(manager.races, id:\.name){ story in
                    StoryCell(story: story)
                }
            }
        }
    }
}


// Will be swipable
struct StoryCell: View {
    var story: Story
    
    var body: some View {
        VStack {
            Image(story.image)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            Spacer()
            
            Text("\(story.name)").bold()
            }.frame(width: 100, alignment: .center)
    }
}



struct Story {
    var name: String
    var image: String
    
    init(name: String, image: String){
        self.name = name
        self.image = image
    }
}


struct Post {
    
    var heading: String
    var text: String
    var likes: Int
    var image: String
    var ago: String
    
    init(heading: String, text: String, likes: Int, image: String, ago: String){
        self.heading = heading
        self.text = text
        self.likes = likes
        self.image = image
        self.ago = ago
    }
}



