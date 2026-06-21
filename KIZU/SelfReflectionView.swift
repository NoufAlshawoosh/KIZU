//
//  SelfReflectionView.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 25/02/2026.
//

import SwiftUI

struct SelfReflectionView: View {

    @EnvironmentObject var store: BoardStore
    @Environment(\.dismiss) var dismiss
    @State private var reflectionText = ""

    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                    }
                    .accessibilityLabel("Cancel")
                    .accessibilityHint("Dismisses without saving")
                    Spacer()
                    Text("What do I feel ?")
                        .font(.title2)
                        .foregroundColor(.black)
                        .accessibilityAddTraits(.isHeader)
                    Spacer()
                    Button { saveAndDismiss() } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                    }
                    .accessibilityLabel("Save reflection")
                    .accessibilityHint("Saves your reflection and the current board")
                }
                .padding(.horizontal)
                .padding(.top, 50)

                TextEditor(text: $reflectionText)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .background(backgroundColor)
                    .cornerRadius(12)
                    .frame(maxHeight: .infinity)
                    .padding()
                    .accessibilityLabel("Reflection text editor")
                    .accessibilityHint("Write how you feel here")
            }
        }
    }

    private func saveAndDismiss() {
        store.saveBoard(reflectionText: reflectionText)
        dismiss()
    }
}
