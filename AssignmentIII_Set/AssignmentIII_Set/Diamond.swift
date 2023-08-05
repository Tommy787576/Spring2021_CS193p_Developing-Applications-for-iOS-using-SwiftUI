//
//  Shapes.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/4.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let left = CGPoint(x: center.x - rect.width / 2, y: center.y)
        let right = CGPoint(x: center.x + rect.width / 2, y: center.y)
        let top = CGPoint(x: center.x, y: center.y - rect.height / 2)
        let bottom = CGPoint(x: center.x, y: center.y + rect.height / 2)
        
        var p = Path()
        p.move(to: left)
        p.addLine(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        
        return p
    }
}
