//
//  SelfReflectionView.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 28/02/2026.
//

import SwiftUI

struct HowToUseAppView: View {
    let onDismiss: () -> Void
    @State private var currentPage = 0
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        TabView(selection: $currentPage) {
            HowToPage1(isActive: currentPage == 0).tag(0)
            HowToPage2(isActive: currentPage == 1).tag(1)
            HowToPage3(isActive: currentPage == 2).tag(2)
            HowToPage4(isActive: currentPage == 3).tag(3)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .ignoresSafeArea()
        .overlay(alignment: .topTrailing) {
            if currentPage == 3 {
                Button { onDismiss() } label: {
                    Text("Done")
                        .foregroundStyle(.black)
                        .font(.headline)
                        .padding()
                        .background(.ultraThinMaterial, in: Capsule())
                }
                .accessibilityLabel("Done")
                .accessibilityHint("Closes the guide and opens the app")
                .padding(.trailing)
                .padding(.top, 50)
                .transition(.opacity)
            }
        }
        .animation(reduceMotion ? .easeInOut(duration: 0.1) : .easeInOut, value: currentPage)
    }
}

// ====================================
struct HowToPage1: View {
    let isActive: Bool
    @State private var currentImage = 0
    @State private var showFirstText = false
    @State private var showText = false
    @State private var showMoreText = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        ZStack {
            Image("BoardPreview1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 0 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            Image("BoardPreview2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 1 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            Image("BoardPreview3")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 2 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            if showFirstText {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .frame(width: 350, height: 80)
                    .overlay {
                        Text("How to use KIZU?")
                            .font(.title3)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    .transition(.opacity)
                    .accessibilityLabel("How to use KIZU?")
            }

            if showText {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .frame(width: 350, height: showMoreText ? 180 : 80)
                    .overlay {
                        VStack(spacing: 6) {
                            Text("Use the tools to hammer in or remove a nail.")
                                .font(.title3)
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)

                            if showMoreText {
                                Text("Complete self-reflection to create a new board.")
                                    .font(.title3)
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.center)
                                    .transition(.opacity)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .animation(reduceMotion ? .none : .easeInOut(duration: 0.4), value: showMoreText)
                    .transition(.opacity)
                    .accessibilityLabel(showMoreText ? "Use the tools to hammer in or remove a nail. Complete self-reflection to create a new board." : "Use the tools to hammer in or remove a nail.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: isActive) { _, active in
            if active { startAnimation() } else { resetAnimation() }
        }
        .onAppear {
            if isActive { startAnimation() }
        }
    }

    private func startAnimation() {
        resetAnimation()
        let fast = reduceMotion
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.1 : 0.5)) {
            guard isActive else { return }
            withAnimation { showFirstText = true }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.2 : 2.0)) {
            guard isActive else { return }
            withAnimation { showFirstText = false }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.3 : 2.5)) {
            guard isActive else { return }
            withAnimation { showText = true }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.3 : 2.5)) {
            guard isActive else { return }
            withAnimation { currentImage = 1 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.4 : 4.0)) {
            guard isActive else { return }
            withAnimation { currentImage = 2 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.5 : 4.5)) {
            guard isActive else { return }
            withAnimation { showMoreText = true }
        }
    }

    private func resetAnimation() {
        currentImage = 0
        showFirstText = false
        showText = false
        showMoreText = false
    }
}

// ====================================
struct HowToPage2: View {
    let isActive: Bool
    @State private var currentImage = 0
    @State private var showText = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        ZStack {
            Image("SelfReflectionPreview1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 0 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            Image("SelfReflectionPreview2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 1 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            if showText {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .frame(width: 350, height: 80)
                    .overlay {
                        Text("Write your reflection below.\nThis is a safe space to be honest with yourself.")
                            .font(.title3)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    .transition(.opacity)
                    .accessibilityLabel("Write your reflection below. This is a safe space to be honest with yourself.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: isActive) { _, active in
            if active { startAnimation() } else { resetAnimation() }
        }
        .onAppear {
            if isActive { startAnimation() }
        }
    }

    private func startAnimation() {
        resetAnimation()
        let fast = reduceMotion
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.1 : 0.5)) {
            guard isActive else { return }
            withAnimation { currentImage = 1 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.2 : 1.0)) {
            guard isActive else { return }
            withAnimation { showText = true }
        }
    }

    private func resetAnimation() {
        currentImage = 0
        showText = false
    }
}

// ====================================
struct HowToPage3: View {
    let isActive: Bool
    @State private var currentImage = 0
    @State private var showText = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        ZStack {
            Image("BoardListPreview1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 0 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            Image("BoardListPreview2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 1 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            if showText {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .frame(width: 350, height: 80)
                    .overlay {
                        Text("Your Board List lets you view and revisit your boards.")
                            .font(.title3)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    .transition(.opacity)
                    .accessibilityLabel("Your Board List lets you view and revisit your boards.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: isActive) { _, active in
            if active { startAnimation() } else { resetAnimation() }
        }
        .onAppear {
            if isActive { startAnimation() }
        }
    }

    private func startAnimation() {
        resetAnimation()
        let fast = reduceMotion
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.1 : 0.5)) {
            guard isActive else { return }
            withAnimation { currentImage = 1 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.2 : 1.0)) {
            guard isActive else { return }
            withAnimation { showText = true }
        }
    }

    private func resetAnimation() {
        currentImage = 0
        showText = false
    }
}

// ====================================
struct HowToPage4: View {
    let isActive: Bool
    @State private var currentImage = 0
    @State private var showText = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        ZStack {
            Image("StoryPreview1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 0 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            Image("StoryPreview2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(currentImage == 1 ? 1 : 0)
                .animation(reduceMotion ? .none : .easeInOut(duration: 0.8), value: currentImage)
                .accessibilityHidden(true)

            if showText {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .frame(width: 350, height: 80)
                    .overlay {
                        Text("The Story tab lets you read the story behind KIZU.")
                            .font(.title3)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    .transition(.opacity)
                    .accessibilityLabel("The Story tab lets you read the story behind KIZU.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: isActive) { _, active in
            if active { startAnimation() } else { resetAnimation() }
        }
        .onAppear {
            if isActive { startAnimation() }
        }
    }

    private func startAnimation() {
        resetAnimation()
        let fast = reduceMotion
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.1 : 0.5)) {
            guard isActive else { return }
            withAnimation { currentImage = 1 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (fast ? 0.2 : 1.0)) {
            guard isActive else { return }
            withAnimation { showText = true }
        }
    }

    private func resetAnimation() {
        currentImage = 0
        showText = false
    }
}
