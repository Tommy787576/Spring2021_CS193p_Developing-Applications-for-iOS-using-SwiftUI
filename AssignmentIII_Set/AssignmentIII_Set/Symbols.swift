//
//  Symbols.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/5.
//

import SwiftUI

// TODO: change number to enum
// count: 0->one, 1->two, 2->three
// form: 0->diamond, 1->squiggle(rectangle), 2->oval
// shading: 0->solid, 0.4->striped(half transparent), 1.0->open
// color: 0->orange, 1->green, 2->purple
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-fill-and-stroke-shapes-at-the-same-time
struct Symbols {
    func get(width: CGFloat, height: CGFloat, count: Int, form: Int, shading: Double, color: Int) -> some View {
        VStack(spacing: 0) {
            Spacer()
            ForEach(0...count, id: \.self) { _ in
                switch form {
                case 0:
                    ZStack {
                        border(form: Diamond(), color: color)
                        filled(form: Diamond(), color: color, shading: shading)
                    }.frame(maxWidth: width, maxHeight: height / 3)
                case 1:
                    ZStack {
                        border(form: Rectangle(), color: color)
                        filled(form: Rectangle(), color: color, shading: shading)
                    }.frame(maxWidth: width, maxHeight: height / 3)
                default:
                    ZStack {
                        border(form: Capsule(), color: color)
                        filled(form: Capsule(), color: color, shading: shading)
                    }.frame(maxWidth: width, maxHeight: height / 3)
                }
            }
            Spacer()
        }
    }
    
    private func filled(form: some Shape, color: Int, shading: Double) -> some View {
        switch color {
        case 0:
            return form.scale(x: 0.8, y: 0.7).fill(.orange).opacity(shading)
        case 1:
            return form.scale(x: 0.8, y: 0.7).fill(.green).opacity(shading)
        default:
            return form.scale(x: 0.8, y: 0.7).fill(.purple).opacity(shading)
        }
    }
    
    private func border(form: some Shape, color: Int) -> some View {
        switch color {
        case 0:
            return form.scale(x: 0.8, y: 0.7).stroke(.orange, lineWidth: 2.0)
        case 1:
            return form.scale(x: 0.8, y: 0.7).stroke(.green, lineWidth: 2.0)
        default:
            return form.scale(x: 0.8, y: 0.7).stroke(.purple, lineWidth: 2.0)
        }
    }
}
