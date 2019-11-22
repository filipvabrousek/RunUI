
/*
 .scaleEffect(isLongPressed ? 1.1 : 1)
 .offset(x: offset.width, y: offset.height)
 */

/*
struct ContentView: View {
    @GestureState var isDetectingLongPress = false

    var body: some View {
        let press = LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
        }


        return Circle()
            .fill(isDetectingLongPress ? Color.yellow : Color.green)
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(press)

    }
}

*/

/*
struct GestureSequence: View {
    @State private var offset: CGSize = .zero
    @GestureState var isPressed = false

    var body: some View {
        let sim = LongPressGesture()
            .updating($isPressed) { value, state, transcation in
                state = value
                
        }
            
        let next = DragGesture().onChanged { _ in
            print("Hey")
        }

        return Rectangle()
            .fill(isPressed ? Color.green : Color.blue)
            .frame(width: 40, height: 40)
            .scaleEffect(isPressed ? 1.2 : 1.0)
            .offset(x: offset.width, y: offset.height)
            .gesture(sim.sequenced(before: next))
    }
}*/


// protocol Shape style = a way to turn shape into View
// conforming types (ImagePaint, Linear, Angular, Radial Gradient), SelectionShapeStyle, SpearatorShapeStyle




struct Gesturea: View {
    @State private var offset: CGSize = .zero
    @GestureState var isPressed = false

    var body: some View {
        let sim = LongPressGesture()
            .updating($isPressed) { value, state, transcation in
                state = value }

        let drag = DragGesture()
            .onChanged {
                self.offset = $0.translation
            }.onEnded {
                _ in self.offset = .zero
        }

        return Rectangle()
            .fill(isPressed ? Color.green : Color.blue)
            .frame(width: 40, height: 40)
            .scaleEffect(isPressed ? 1.2 : 1.0)
            .offset(x: offset.width, y: offset.height)
            .gesture(sim.sequenced(before: drag))
        // sequenced, simultaneously, exclusively
    }
}

struct Capsulea: View {
    var body: some View {
        let grad = AngularGradient(gradient: Gradient(colors: [.orange, .yellow]), center: .center)
        return Capsule().fill(grad)
    }
}


struct MagView: View {
    @GestureState var tapped = false

    var body: some View {
        var st = TapGesture()
            .updating($tapped, body: { (f, state, trans) in
                print(self.$tapped)
            })


        // st is GestureStateGesture<TapGesture, Bool>

        return Rectangle().frame(width: 100, height: 100)
            .gesture(MagnificationGesture()
                    .onChanged { _ in
                        print("Hello")
                }
                , including: .subviews)
        // .subviews is a gesture Mask, allows to boradcast value to subviews

        // Vector arithmetic (conforming types = Animatable Pair, CGFloat, Double, Float, Empty Animatable Data)


        
    }
}


/*
 
 EquatableView
 
 /// A view type that compares itself against its previous value and
 /// prevents its child updating if its new value is the same as its old
 /// value.
 @available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
 public struct EquatableView<Content> : View where Content : Equatable, Content : View {

     public var content: Content

     @inlinable public init(content: Content)

     /// The type of view representing the body of this view.
     ///
     /// When you create a custom view, Swift infers this type from your
     /// implementation of the required `body` property.
     public typealias Body = Never
 }
 
 
 */

/*
 
 
 let loc: LocalizedStrinkgKey = "translation"
 let text = Text(loc) // looking for a "translation" key in trnaslation files and translates
 
 
 
 struct SwiftUIView: View {
     // ❇️ The BlogIdea class has an `allIdeasFetchRequest` static function that can be used here
     @FetchRequest(fetchRequest: BlogIdea.allIdeasFetchRequest()) var blogIdeas: FetchedResults<BlogIdea>

     var body: some View {
         List(self.blogIdeas) { blogIdea in
             Text(blogIdea.ideaTitle ?? "")
         }
     }
 }

 */

/*
 MacOS
 (MenuButton, PasteButton) only on Mac, you can use like regular button
 
 GroupBox = stylized view with an optional label that is associated with a logical grouping of content.
 
 VSplitView = A layout container that arranges its children in a vertical line and allows the user to resize them using dividers placed between them.
 */


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MagView()
        }
    }
}
