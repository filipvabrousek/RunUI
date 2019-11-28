# Follow path


## Follower
```swift
struct Follower: View {
    @State var xpoints = [CGFloat]()
    @State var ypoints = [CGFloat]()
    @State var index: Double = 0.0

    var body: some View {
        VStack {
            if xpoints.count > 0 {
                ZStack {
                    Circle()
                        .frame(width: 20)
                        .foregroundColor(.white)
                        .position(x: xpoints[Int(index)], y: ypoints[Int(index)])
                    Wave(gw: 1, amplitude: 0.05).stroke()
                }

                Slider(value: $index, in: 1.0...Double(xpoints.count / 20), step: 0.01)

            } else {
                Text("Loading")
            }
        }

            .onAppear {
                let val = UserDefaults.standard.value(forKey: "xPoints") as? [CGFloat]
                let mal = UserDefaults.standard.value(forKey: "yPoints") as? [CGFloat]

                if (val != nil && mal != nil) {
                    self.xpoints = val!
                    self.ypoints = mal!
                }
        }
    }
}

```


## Wave
```swift
struct Wave: Shape {
    let gw: CGFloat
    let amplitude: CGFloat

    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height

        let origin = CGPoint(x: 0, y: h * 0.50)
        var path = Path()
        path.move(to: origin)

        var end: CGFloat = 0.0
        let step = 5.0

        for angle in stride(from: step, through: Double(w) * step * step, by: step) {
            let x = origin.x + CGFloat(angle / 360.0) * w * gw
            let y = origin.y - CGFloat(sin(angle / 180.0 * Double.pi)) * h * amplitude
            path.addLine(to: .init(x: x, y: y))
            end = y
        }

        path.addLine(to: .init(x: w, y: end))
        UserDefaults.standard.set(path.cgPath.points.map { $0.x }, forKey: "xPoints")
        UserDefaults.standard.set(path.cgPath.points.map { $0.y }, forKey: "yPoints")
        return path
    }
}
```


## CGPath extension 
```swift


extension CGPath {
    func forEach(body: @escaping @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        //print(MemoryLayout.size(ofValue: body))
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }


    var points: [CGPoint] {
        var arrayPoints: [CGPoint]! = [CGPoint]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
            default: break
            }
        }
        return arrayPoints
    }
}

```
