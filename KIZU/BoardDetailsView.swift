//
//  BoardDetailsView.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 26/02/2026.
//
import SwiftUI

struct BoardDetailView: View {

    let board: SavedBoard
    let onDismiss: () -> Void
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    private var nails:   [(CGPoint, Double)] { board.nails.map { $0.asTuple } }
    private var removed: [(CGPoint, Double)] { board.removedNails.map { $0.asTuple } }

    var body: some View {
        TabView {
            ZStack {
                BoardBackground()
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: board.canvasWidth, height: board.canvasHeight)
                    .overlay {
                        NailsLayer(
                            currentTool: .none,
                            nailPositions: .constant(nails),
                            removedNailPositions: .constant(removed)
                        )
                    }
            }
            .ignoresSafeArea()
            .accessibilityLabel("Saved board with \(nails.count) nails and \(removed.count) removed nail spots")

            ReflectionPage(text: board.reflectionText, date: board.date)
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button { onDismiss() } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .font(.title2)
                    .padding()
                    .background(.ultraThinMaterial, in: Circle())
            }
            .accessibilityLabel("Back")
            .accessibilityHint("Returns to the boards list")
            .padding(.leading)
            .padding(.top, 50)
        }
    }

    struct ReflectionPage: View {

        let text: String
        let date: Date

        private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)

        var body: some View {
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack {
                    Text("What do I feel ?")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.top, 50)
                        .accessibilityAddTraits(.isHeader)
                    Text(date, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                    ScrollView {
                        Text(text.isEmpty ? "No reflection written." : text)
                            .font(.body)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    Spacer()
                }
            }
            .accessibilityLabel("Reflection for \(date.formatted(date: .long, time: .omitted))")
        }
    }
}
