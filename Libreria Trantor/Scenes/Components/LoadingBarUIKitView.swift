//
//  LoadingBarUIKitView.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 30/3/23.
//

import UIKit

let GLHeight: CGFloat = 5
let GLStripeWidth: CGFloat = 24

class LoadingBarView: UIView {

    private var timer: Timer?
    private var stripesOffset: CGFloat = 0
    
    var trackTintColor = UIColor(red: 253/255.0, green: 74/255.0, blue: 74/255.0, alpha: 1)
    var stripesColor = UIColor(red: 176/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    
    init(width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: GLHeight))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()!
        
        stripesOffset = (stripesOffset < 0) ? 2 * GLStripeWidth-1 : stripesOffset - 1
        
        trackTintColor.set()
        context.fill(rect)
        
        drawStripes(context: context, rect: rect)
    }
    
    private func drawStripes(context: CGContext, rect: CGRect) {
        context.saveGState()
        
        let stripes = UIBezierPath()
        
        let start = -GLStripeWidth
        let end = rect.size.width / (2 * GLStripeWidth) + (2 * GLStripeWidth)
        for i in Int(start)...Int(end) {
            let origin = CGPoint(x: CGFloat(i) * 2 * GLStripeWidth + stripesOffset, y: 0)
            let stripe = stripeWithOrigin(origin: origin, bounds: rect)
            stripes.append(stripe)
        }
        
        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: 0)
        
        context.addPath(clipPath.cgPath)
        context.clip()
        
        context.saveGState()
        context.addPath(stripes.cgPath)
        context.clip()
        
        stripesColor.set()
        context.fill(rect)
        
        context.restoreGState()
        context.restoreGState()
    }
    
    private func stripeWithOrigin(origin: CGPoint, bounds: CGRect) -> UIBezierPath {
        let height = bounds.height
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: origin)
        bezierPath.addLine(to: CGPoint(x: origin.x + GLStripeWidth, y: origin.y))
        bezierPath.addLine(to: CGPoint(x: origin.x + GLStripeWidth - 4, y: origin.y + height))
        bezierPath.addLine(to: CGPoint(x: origin.x - 4, y: origin.y + height))
        bezierPath.addLine(to: origin)
        bezierPath.close()
        
        return bezierPath
    }
    
    var animated: Bool = false {
        didSet {
            if animated {
                timer = Timer.scheduledTimer(withTimeInterval: 1/50.0, repeats: true) { [weak self] _ in
                    self?.setNeedsDisplay()
                }
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}

