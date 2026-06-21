//
//  Model.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 28/02/2026.
//
import SwiftUI

struct NailEntry: Codable {
    let x: CGFloat, y: CGFloat, rotation: Double
    init(_ p: CGPoint, _ r: Double) { x = p.x; y = p.y; rotation = r }
    var asTuple: (CGPoint, Double) { (CGPoint(x: x, y: y), rotation) }
}

