//
//  BoardListView.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 25/02/2026.
//
import SwiftUI

struct BoardsListView: View {

    @EnvironmentObject var store: BoardStore
    @Binding var selectedTab: Int
    @Binding var selectedBoard: SavedBoard?
    @Binding var showHowTo: Bool

    @State private var showReflection = false

    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)

    private var boardsByMonth: [(String, [SavedBoard])] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        let grouped = Dictionary(grouping: store.boards) { formatter.string(from: $0.date) }
        return grouped.sorted { a, b in
            (a.value.first?.date ?? .distantPast) > (b.value.first?.date ?? .distantPast)
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()

            HStack(alignment: .top) {
                Text("My Boards")
                    .font(.title2.bold())
                    .foregroundStyle(.black)
                    .accessibilityAddTraits(.isHeader)
                Text(Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 6)
                    .accessibilityLabel("Today is \(Date().formatted(date: .long, time: .omitted))")
                Spacer()
                Button { showHowTo = true } label: {
                    Image(systemName: "i.circle")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                .accessibilityLabel("How to use KIZU")
                .accessibilityHint("Opens the how to use the app guide")
                .padding(.leading, 12)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            VStack(alignment: .leading, spacing: 16) {
                Text("Current Board")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .accessibilityAddTraits(.isHeader)

                BoardCard(
                    nails: store.nailPositions,
                    removedNails: store.removedNailPositions,
                    dateText: Date().formatted(date: .abbreviated, time: .omitted)
                )
                .onTapGesture { selectedTab = 0 }
                .accessibilityLabel("Current board with \(store.nailPositions.count) nails")
                .accessibilityHint("Tap to go to the current board")
                .padding(.horizontal, 6)

                Divider().padding(.vertical, 10)

                Text("My Previous Boards")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .accessibilityAddTraits(.isHeader)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(boardsByMonth, id: \.0) { month, monthBoards in
                            HStack {
                                Text(month)
                                    .font(.subheadline.bold())
                                    .foregroundColor(.black.opacity(0.85))
                                    .accessibilityAddTraits(.isHeader)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.trailing)
                                    .opacity(0.3)
                                    .accessibilityHidden(true)
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(monthBoards) { board in
                                        BoardCard(
                                            nails: board.nails.map { $0.asTuple },
                                            removedNails: board.removedNails.map { $0.asTuple },
                                            dateText: board.date.formatted(.dateTime.day().month(.abbreviated))
                                        )
                                        .onTapGesture { selectedBoard = board }
                                        .accessibilityLabel("Board from \(board.date.formatted(date: .long, time: .omitted)) with \(board.nails.count) nails")
                                        .accessibilityHint("Tap to view this board")
                                        .padding(.leading, 6)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            .padding(.top, 65)
            .padding(.horizontal, 20)
        }
    }
}

struct BoardCard: View {

    let nails: [(CGPoint, Double)]
    let removedNails: [(CGPoint, Double)]
    let dateText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            GeometryReader { geo in
                let scale = geo.size.width / UIScreen.main.bounds.width
                ZStack {
                    Image("WoodenBoard").resizable().scaledToFill()
                        .accessibilityHidden(true)
                    ForEach(nails.indices, id: \.self) { i in
                        Image("Nail2")
                            .rotationEffect(.degrees(nails[i].1))
                            .position(x: nails[i].0.x * scale, y: nails[i].0.y * scale)
                            .accessibilityHidden(true)
                    }
                    ForEach(removedNails.indices, id: \.self) { i in
                        Image("RemovedNailSpot")
                            .rotationEffect(.degrees(removedNails[i].1))
                            .position(x: removedNails[i].0.x * scale, y: removedNails[i].0.y * scale)
                            .accessibilityHidden(true)
                    }
                }
                .clipped()
            }
            .frame(width: 140, height: 100)
            .cornerRadius(10)

            Text(dateText)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
