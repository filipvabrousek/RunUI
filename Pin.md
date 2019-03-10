# Pin.swift
* Simple Swift Auto Layout library for building effortless constraints

## Examples:

```swift
view.pin(a: .top, b: .center, ac: 200, bc: 0, w: 200, h: 30, to: nil)
```
```swift
map.bottomPin(top: 250, safe: false)
```

```swift
view.pinTo(another, position: .bottom, h: 40, margin: 10)
```

## Source:
```swift

import UIKit

extension UIView {
    enum P {
        case top
        case bottom
    }
    
    enum O {
        case left
        case right
        case center
        case middle
    }
    
    
    enum S {
        case top
        case bottom
    }
    
    func ignorePin(a: S, dist: CGFloat, w: CGFloat, h:CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        self.heightAnchor.constraint(equalToConstant: h).isActive = true
        
        let sup = self.superview!
        
        if a == .bottom {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -dist).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: dist).isActive = true
        }
    }
    
    func bottomPin(top: CGFloat, safe: Bool){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width).isActive = true
        
        if safe == true {
            self.bottomAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor).isActive = true
        }
        
        
        
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    func bottomPinBeta(top: CGFloat, bottom:CGFloat?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width).isActive = true
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -bottom!).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor).isActive = true
        }
        
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    
    func centerPin(margin: CGFloat, top: CGFloat, bottom:CGFloat?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width - margin).isActive = true
        self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true
        
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -bottom!).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor).isActive = true
        }
        
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    
    func centerAPin(margin: CGFloat, top: CGFloat, height:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalToConstant: sup.frame.width - margin).isActive = true
        self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        
        self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
    }
    
    
    func stretchPin(top: UIView?, left:UIView?, right:UIView?, bottom: UIView?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        self.widthAnchor.constraint(equalTo: sup.widthAnchor).isActive = true
        
        if top != nil {
            self.topAnchor.constraint(equalTo: top!.bottomAnchor, constant: 0).isActive = true
        }
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: bottom!.topAnchor, constant: 0).isActive = true
        }
    }
    
    
    func fillsuperview(top: CGFloat?, left: CGFloat?, right: CGFloat?, bottom: CGFloat?){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        
        if top != nil {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: top!).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: 0).isActive = true
        }
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -bottom!).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: 0).isActive = true
        }
        
        
        if left != nil {
            self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: left!).isActive = true
        } else {
            self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: 0).isActive = true
        }
        
        
        if right != nil {
            self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: right!).isActive = true
        } else {
            self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: 0).isActive = true
        }
    }
    
    
    
    func toAuto(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func pin(w: CGFloat, h: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        self.heightAnchor.constraint(equalToConstant: h).isActive = true
    }
    
    func pin(a: P, b: O, ac: CGFloat, bc:CGFloat, w: CGFloat, h:CGFloat, to:UIView?){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        self.heightAnchor.constraint(equalToConstant: h).isActive = true
        
        
        let sup = self.superview!
        
        if a == .bottom {
            self.bottomAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor, constant: -ac).isActive = true
        }
        
        if a == .top && b != .center {
            self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }
        
        if a == .top && b == .center {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }
        
        if a == .bottom && b == .center {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.bottomAnchor, constant: ac).isActive = true
        }
        
        
        
        if a == .top && b == .middle {
            self.topAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.topAnchor, constant: ac).isActive = true
        }
        
        if b == .right {
            self.rightAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.rightAnchor, constant: -bc).isActive = true
        }
        
        if b == .left {
            self.leftAnchor.constraint(equalTo: sup.safeAreaLayoutGuide.leftAnchor, constant: bc).isActive = true
        }
        
        if a == .top && b == .center && to != nil {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: (to?.bottomAnchor)!, constant: ac).isActive = true
        }
        
        if a == .bottom && b == .center && to != nil {
            self.centerXAnchor.constraint(equalTo: sup.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: (to?.bottomAnchor)!, constant: -ac).isActive = true
        }
        
        
    }
    
    
    
    
    func stretch(within: UIView, insets: [CGFloat]){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = within
        self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets[0]).isActive = true
        self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: insets[1]).isActive = true
        self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -insets[2]).isActive = true
        self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -insets[3]).isActive = true
        
    }
    
    
    
    
    
    
    
    
    
    
    func stretchooo(within: UIView, contentWidth: CGFloat, height: CGFloat, insets: [CGFloat]){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = within
        
        let final = (contentWidth / self.frame.width) * self.frame.width
        
        self.widthAnchor.constraint(equalToConstant: final).isActive = true
        
        self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets[0]).isActive = true
        
        self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: insets[1]).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    
    
    
    
    func stretchH(within: UIView, height: CGFloat, insets: [CGFloat]){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = within
        self.topAnchor.constraint(equalTo: sup.topAnchor, constant: insets[0]).isActive = true
        self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: insets[1]).isActive = true
        self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -insets[2]).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    
    
    func stretch(top: UIView?, left: UIView?, right: UIView?, bottom: UIView?, padding: [CGFloat]){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        if top != nil {
            self.topAnchor.constraint(equalTo: top!.bottomAnchor, constant: padding[0]).isActive = true
        } else {
            self.topAnchor.constraint(equalTo: sup.topAnchor, constant: padding[0]).isActive = true
        }
        
        
        if left != nil {
            self.leftAnchor.constraint(equalTo: left!.leftAnchor, constant: padding[1]).isActive = true
        } else {
            self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: padding[1]).isActive = true
        }
        
        
        if right != nil {
            self.rightAnchor.constraint(equalTo: right!.rightAnchor, constant: -padding[2]).isActive = true
        } else {
            self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -padding[2]).isActive = true
        }
        
        if bottom != nil {
            self.bottomAnchor.constraint(equalTo: bottom!.topAnchor, constant: -padding[3]).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: sup.bottomAnchor, constant: -padding[3]).isActive = true
        }
        
        
    }
    
    
    
    
    enum Q {
        case top
        case bottom
        case left
        case right
    }
    
    
    
    
    
    func paddingPin(_ view: UIView?, position: Q, w: CGFloat, h: CGFloat, margin: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        self.widthAnchor.constraint(equalToConstant: w).isActive = true
        self.centerXAnchor.constraint(equalTo: sup.centerXAnchor, constant: 0).isActive = true
        
        
        if position == .top {
            
            if view != nil {
                self.bottomAnchor.constraint(equalTo: view!.topAnchor, constant: -margin).isActive = true
            } else {
                self.bottomAnchor.constraint(equalTo: sup.topAnchor, constant: -margin).isActive = true
            }
        }
        
        
        
        if position == .left {
            if view != nil {
                self.leftAnchor.constraint(equalTo: view!.leftAnchor, constant: margin).isActive = true
            } else {
                self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: margin).isActive = true
            }
        }
        
        
        
        if position == .right {
            if view != nil {
                self.rightAnchor.constraint(equalTo: view!.rightAnchor, constant: -margin).isActive = true
            } else {
                self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -margin).isActive = true
            }
        }
        
        
        
        if position == .bottom {
            if view != nil {
                self.topAnchor.constraint(equalTo: view!.bottomAnchor, constant: margin).isActive = true
            } else {
                self.topAnchor.constraint(equalTo: sup.bottomAnchor, constant: margin).isActive = true
            }
        }
    }
    
    
    func pinTo(_ view: UIView?, position: Q, h: CGFloat, margin: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        let sup = self.superview!
        
        self.heightAnchor.constraint(equalToConstant: h).isActive = true
        self.widthAnchor.constraint(equalTo: sup.widthAnchor).isActive = true
        
        if position == .top {
            
            if view != nil {
                self.bottomAnchor.constraint(equalTo: view!.topAnchor, constant: -margin).isActive = true
            } else {
                self.bottomAnchor.constraint(equalTo: sup.topAnchor, constant: -margin).isActive = true
            }
        }
        
        
        
        if position == .left {
            if view != nil {
                self.leftAnchor.constraint(equalTo: view!.leftAnchor, constant: margin).isActive = true
            } else {
                self.leftAnchor.constraint(equalTo: sup.leftAnchor, constant: margin).isActive = true
            }
        }
        
        
        
        
        if position == .right {
            if view != nil {
                self.rightAnchor.constraint(equalTo: view!.rightAnchor, constant: -margin).isActive = true
            } else {
                self.rightAnchor.constraint(equalTo: sup.rightAnchor, constant: -margin).isActive = true
            }
        }
        
        
        
        if position == .bottom {
            if view != nil {
                self.topAnchor.constraint(equalTo: view!.bottomAnchor, constant: margin).isActive = true
            } else {
                self.topAnchor.constraint(equalTo: sup.bottomAnchor, constant: margin).isActive = true
            }
        }
        
        
    }
}


```
