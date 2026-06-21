import SwiftUI

struct ContentView: View {

    @StateObject private var store = BoardStore()
    @State private var selectedTab = 0
    @State private var selectedBoard: SavedBoard? = nil
    @State private var showHowTo = false

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Board", systemImage: "light.panel", value: 0) {
                BoardView()
            }
            
            Tab("Story", systemImage: "book", value: 1) {
                StoryView()
            }
            
            Tab("List", systemImage: "list.bullet", value: 2) {
                BoardsListView(selectedTab: $selectedTab, selectedBoard: $selectedBoard, showHowTo: $showHowTo)
            }
            
        }
        .environmentObject(store)
        .overlay {
            if let board = selectedBoard {
                BoardDetailView(board: board, onDismiss: { selectedBoard = nil })
                    .ignoresSafeArea()
                    .transition(.move(edge: .trailing))
            }
            if showHowTo {
                HowToUseAppView(onDismiss: { showHowTo = false })
                    .ignoresSafeArea()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: selectedBoard?.id)
        .animation(.easeInOut(duration: 0.3), value: showHowTo)
    }
}
