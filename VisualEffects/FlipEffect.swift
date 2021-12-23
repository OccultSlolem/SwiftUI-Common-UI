//
//  FlipEffect.swift
//  Politifi
//
//  Created by Ethan Hanlon on 3/27/21.
//

import Foundation
import SwiftUI

public struct FlipEffect: GeometryEffect {
    public func effectValue(size: CGSize) -> ProjectionTransform {
        let t = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
        return ProjectionTransform(t)
    }
}
