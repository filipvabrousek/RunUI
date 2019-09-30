//
//  FeedView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 29/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import Combine


/*
struct FeedView: View {
    var body: some View {
        Text("List would crash in iOS 13.1")
    }
}*/



struct FeedView: View {
    @EnvironmentObject var postf: PostFetcher
    @State var fetcher = FeedFetcher()

    var body: some View {
        VStack {
            FeedHeader().padding(10)

            List {
                StoryView()//.frame(width: UIScreen.main.bounds.width + 30)
                ForEach(postf.posts, id: \.heading) { p in // posts
                    PostCell(post: p)
                }
            }
        }
    }
}




struct FeedHeader: View {
    @State var show = false

    var body: some View {
        HStack {
            Text("Feed").font(.system(size: 30)).bold()
            Spacer()
            Button("Send") {
                self.show.toggle()
            }.modifier(Send())
                .sheet(isPresented: $show) {
                    SheetView()
            }

        }
    }
}

struct SheetView: View {
    var body: some View {
        Text("Hey there, I am sheet!").bold()
    }
}

struct PostCell: View {
    var post: Post
    @State var hidden = true
    @State var tapped = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("third").resizable().frame(width: 30, height: 30).clipShape(Circle())
                Text(post.heading).fontWeight(.bold)
            }.frame(height: 40)


            ZStack(alignment: .center) { // Diagram
                Image(post.image).resizable().scaledToFit()
                    .gesture(TapGesture(count: 2).onEnded {
                            print("Now") // show hearts
                            self.hidden = false
                            self.tapped = true

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                self.hidden = true
                            }
                        })


                if hidden == false {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .opacity(0.6).foregroundColor(Color.white)
                }
            }

            /*
             Create new into documents
             Right click add View
             Double click package - add Diagram
             BPMN 2.0 - diagram
             Pool poklikat -> General
             */

            VStack(alignment: .leading) {
                HStack {
                    HStack {
                        Image(systemName: "heart").onTapGesture {
                            self.tapped.toggle()
                        }.foregroundColor(tapped ? Color.red : Color("Invert"))

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
                Text(post.text)
                Text("View 1 comment").font(.system(.body))
                    .modifier(PostSecondary())
                Text(post.ago).font(.system(size: 12))
            }
        }
    }
}








struct StoryView: View {
    @State var manager = FeedFetcher()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(manager.races, id: \.name) { story in
                    StoryCell(story: story)
                }
            }
        }
    }
}




struct StoryDetail: View {
    var body: some View {
        Image("")
    }
}

// Will be swipable
struct StoryCell: View {
    var story: Story

    var body: some View {
        VStack {
            Image(story.image)
                .resizable()
                .frame(width: 73, height: 73)
                .overlay(Circle().stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .top, endPoint: .bottom), lineWidth: 4.0))
                .clipShape(Circle())

            Spacer()

            Text("\(story.name)").bold()
        }.frame(width: 100, alignment: .center)
            .onTapGesture {
                print("Now")
        }
    }
}




struct Story {
    var name: String
    var image: String

    init(name: String, image: String) {
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

    init(heading: String, text: String, likes: Int, image: String, ago: String) {
        self.heading = heading
        self.text = text
        self.likes = likes
        self.image = image
        self.ago = ago
    }
}

class PostFetcher: ObservableObject {
    @Published var posts = [Post]() //  [Post]()

    init() {
        posts = [
            Post(heading: "Filip Vabroušek", text: "At the race I managed to win overall. The course led through some really though boulders... ", likes: 13200, image: "first", ago: "24 seconds ago"),
            Post(heading: "Petr Vabroušek", text: "1st place Oravaman: I lead the pack during the first 5k and then I took the first place overall, while smashing my PB of 32:30", likes: 4200, image: "second", ago: "1 minute ago"),
            Post(heading: "Tereza", text: "Today I flew to Balkan on my Vacation and it went great!!", likes: 2400, image: "third", ago: "6 minutes ago")

        ]
    }
}
