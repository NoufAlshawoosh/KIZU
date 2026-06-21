//
//  SavedBoard.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 28/02/2026.
//
import SwiftUI

struct SavedBoard: Identifiable, Codable {
    let id: UUID
    let date: Date
    let nails: [NailEntry]
    let removedNails: [NailEntry]
    let reflectionText: String
    let canvasWidth: CGFloat
    let canvasHeight: CGFloat
}
