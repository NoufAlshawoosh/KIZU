//
//  BoardStoreVM.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 28/02/2026.
//
import SwiftUI
import Combine

@MainActor
class BoardStore: ObservableObject {

    @Published var nailPositions: [(CGPoint, Double)] = []        { didSet { persistNails() } }
    @Published var removedNailPositions: [(CGPoint, Double)] = [] { didSet { persistNails() } }
    @Published var boards: [SavedBoard] = []
    var canvasSize: CGSize = .zero
    var canvasOrigin: CGPoint = .zero

    private let nailsKey   = "nail_positions"
    private let removedKey = "removed_nail_positions"
    private let boardsKey  = "saved_boards"

    init() { loadNails(); loadBoards() }

    func saveBoard(reflectionText: String) {
        boards.insert(SavedBoard(
            id: UUID(),
            date: Date(),
            nails: nailPositions.map { NailEntry($0.0, $0.1) },
            removedNails: removedNailPositions.map { NailEntry($0.0, $0.1) },
            reflectionText: reflectionText,
            canvasWidth: canvasSize.width,
            canvasHeight: canvasSize.height
        ), at: 0)
        nailPositions = []
        removedNailPositions = []
        persistBoards()
    }

    private func persistNails() {
        UserDefaults.standard.set(try? JSONEncoder().encode(nailPositions.map { NailEntry($0.0, $0.1) }), forKey: nailsKey)
        UserDefaults.standard.set(try? JSONEncoder().encode(removedNailPositions.map { NailEntry($0.0, $0.1) }), forKey: removedKey)
    }

    private func loadNails() {
        if let d = UserDefaults.standard.data(forKey: nailsKey),
           let e = try? JSONDecoder().decode([NailEntry].self, from: d) { nailPositions = e.map { $0.asTuple } }
        if let d = UserDefaults.standard.data(forKey: removedKey),
           let e = try? JSONDecoder().decode([NailEntry].self, from: d) { removedNailPositions = e.map { $0.asTuple } }
    }

    private func persistBoards() {
        UserDefaults.standard.set(try? JSONEncoder().encode(boards), forKey: boardsKey)
    }

    private func loadBoards() {
        guard let d = UserDefaults.standard.data(forKey: boardsKey),
              let s = try? JSONDecoder().decode([SavedBoard].self, from: d) else { return }
        boards = s
    }
}
