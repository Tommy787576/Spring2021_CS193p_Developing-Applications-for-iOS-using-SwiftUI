//
//  Symbols.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/5.
//

import SwiftUI

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-fill-and-stroke-shapes-at-the-same-time
struct Symbols {
    func get(width: CGFloat, height: CGFloat, count: Count, form: Form, shading: Shading, color: ShapeColor) -> some View {
        VStack(spacing: 0) {
            Spacer()
            ForEach(0...count.rawValue, id: \.self) { _ in
                switch form {
                case .diamond:
                    ZStack {
                        border(form: Diamond(), color: color)
                        filled(form: Diamond(), color: color, shading: shading)
                    }.frame(maxWidth: width, maxHeight: height / 3)
                case .rectangle:
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
    
    private func filled(form: some Shape, color: ShapeColor, shading: Shading) -> some View {
        switch color {
        case .orange:
            return form.scale(x: 0.8, y: 0.7).fill(.orange).opacity(shading.rawValue)
        case .green:
            return form.scale(x: 0.8, y: 0.7).fill(.green).opacity(shading.rawValue)
        default:
            return form.scale(x: 0.8, y: 0.7).fill(.purple).opacity(shading.rawValue)
        }
    }
    
    private func border(form: some Shape, color: ShapeColor) -> some View {
        switch color {
        case .orange:
            return form.scale(x: 0.8, y: 0.7).stroke(.orange, lineWidth: 2.0)
        case .green:
            return form.scale(x: 0.8, y: 0.7).stroke(.green, lineWidth: 2.0)
        default:
            return form.scale(x: 0.8, y: 0.7).stroke(.purple, lineWidth: 2.0)
        }
    }
}
