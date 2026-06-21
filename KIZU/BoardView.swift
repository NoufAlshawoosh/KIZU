//
//  BoardView.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 24/02/2026.
//
import SwiftUI

struct BoardView: View {

    enum ToolMode { case nail, nailRemover, none }

    @EnvironmentObject var store: BoardStore
    @State private var currentTool: ToolMode = .none
    @State private var showReflection = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        NavigationStack {
            ZStack {
                BoardBackground()
                BoardCanvas(
                    currentTool: $currentTool,
                    nailPositions: $store.nailPositions,
                    removedNailPositions: $store.removedNailPositions
                )
            }
            .toolbar {
                BoardToolbar(currentTool: $currentTool, showReflection: $showReflection)
            }
            .fullScreenCover(isPresented: $showReflection) {
                SelfReflectionView()
            }
        }
    }
}

struct BoardBackground: View {
    var body: some View {
        Image("WoodenBoard")
            .resizable()
            .ignoresSafeArea()
            .accessibilityHidden(true)
    }
}

struct BoardToolbar: ToolbarContent {

    @Binding var currentTool: BoardView.ToolMode
    @Binding var showReflection: Bool

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button { showReflection = true } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.primary)
                    .font(.title2)
            }
            .accessibilityLabel("Save board and reflect")
            .accessibilityHint("Opens the self reflection view to save your current board")
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button { currentTool = currentTool == .nailRemover ? .none : .nailRemover } label: {
                Image("NailRemoverTool")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(currentTool == .nailRemover ? Color.accentColor : .primary)
            }
            .accessibilityLabel("Nail remover tool")
            .accessibilityHint("Tap to select the nail remover tool. Tap a nail on the board to remove it")
            .accessibilityAddTraits(currentTool == .nailRemover ? .isSelected : [])
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button { currentTool = currentTool == .nail ? .none : .nail } label: {
                Image("NailTool")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(currentTool == .nail ? Color.accentColor : .primary)
            }
            .accessibilityLabel("Nail tool")
            .accessibilityHint("Tap to select the nail tool. Tap the board to hammer a nail")
            .accessibilityAddTraits(currentTool == .nail ? .isSelected : [])
        }
    }
}

struct BoardCanvas: View {

    @EnvironmentObject var store: BoardStore
    @Binding var currentTool: BoardView.ToolMode
    @Binding var nailPositions: [(CGPoint, Double)]
    @Binding var removedNailPositions: [(CGPoint, Double)]

    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .onAppear {
                    DispatchQueue.main.async {
                        store.canvasSize = geo.size
                        store.canvasOrigin = geo.frame(in: .global).origin
                    }
                }
                .onChange(of: geo.size) { _, newSize in
                    store.canvasSize = newSize
                    store.canvasOrigin = geo.frame(in: .global).origin
                }
                .gesture(DragGesture(minimumDistance: 0).onEnded { value in
                    switch currentTool {
                    case .nail:
                        nailPositions.append((value.location, Double.random(in: -60...60)))
                    case .nailRemover:
                        if let i = nailPositions.firstIndex(where: {
                            sqrt(pow($0.0.x - value.location.x, 2) + pow($0.0.y - value.location.y, 2)) < 12
                        }) { removedNailPositions.append(nailPositions.remove(at: i)) }
                    case .none: break
                    }
                })
                .overlay {
                    NailsLayer(
                        currentTool: currentTool,
                        nailPositions: $nailPositions,
                        removedNailPositions: $removedNailPositions
                    )
                }
                .accessibilityLabel("Board canvas")
                .accessibilityHint(currentTool == .nail ? "Tap to hammer a nail" : currentTool == .nailRemover ? "Tap a nail to remove it" : "Select a tool from the toolbar")
        }
    }
}

struct NailsLayer: View {

    let currentTool: BoardView.ToolMode
    @Binding var nailPositions: [(CGPoint, Double)]
    @Binding var removedNailPositions: [(CGPoint, Double)]

    var body: some View {
        ZStack {
            ForEach(nailPositions.indices, id: \.self) { i in
                Image("Nail2")
                    .rotationEffect(.degrees(nailPositions[i].1))
                    .position(nailPositions[i].0)
                    .accessibilityLabel("Nail \(i + 1)")
                    .accessibilityHint(currentTool == .nailRemover ? "Tap to remove this nail" : "")
                    .onTapGesture {
                        if currentTool == .nailRemover {
                            removedNailPositions.append(nailPositions.remove(at: i))
                        }
                    }
            }
            ForEach(removedNailPositions.indices, id: \.self) { i in
                Image("RemovedNailSpot")
                    .rotationEffect(.degrees(removedNailPositions[i].1))
                    .position(removedNailPositions[i].0)
                    .accessibilityHidden(true)
            }
        }
    }
}
