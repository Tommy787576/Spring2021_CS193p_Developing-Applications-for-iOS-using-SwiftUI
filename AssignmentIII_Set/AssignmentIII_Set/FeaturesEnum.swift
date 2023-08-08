//
//  FeaturesEnum.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/8.
//

import SwiftUI

enum Count: Int, CaseIterable {
    case one, two, three
}

enum Form: CaseIterable {
    case diamond, rectangle, oval
}

// shading: 0->solid, 0.4->striped(half transparent), 1.0->open
enum Shading: Double, CaseIterable {
    case solid = 0.0, halfTransparent = 0.4, open = 1.0
}

enum ShapeColor: CaseIterable {
    case orange, green, purple

}
