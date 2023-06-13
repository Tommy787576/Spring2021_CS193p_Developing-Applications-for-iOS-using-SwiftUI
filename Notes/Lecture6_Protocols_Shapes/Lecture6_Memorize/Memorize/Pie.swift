//
//  Pie.swift
//  Memorize
//
//  Created by 林士平 on 2023/6/13.
//

import SwiftUI

struct Pie: Shape {
    // startAngle and endAngle gonna be animated so must be var
    var startAngle: Angle
    var endAngle: Angle
    // clockwise also have to be var to let people able to specify it
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise   // since the origin is at top-left of the card not bottom-left
        )
        p.addLine(to: center)
        
        return p
    }
}
