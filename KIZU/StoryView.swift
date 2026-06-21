//
//  SelfReflectionView.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 27/02/2026.
//

import SwiftUI

struct StoryView: View {
    let onHowTo: (() -> Void)?
    @State private var currentPage = 0
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    init(onHowTo: (() -> Void)? = nil) {
        self.onHowTo = onHowTo
    }

    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                FirstPageView().tag(0)
                SecondPageView().tag(1)
                ThirdPageView(isActive: currentPage == 2).tag(2)
                ForthPageView().tag(3)
                FifthPageView(isActive: currentPage == 4).tag(4)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .ignoresSafeArea()

            VStack {
                Spacer()
                if currentPage == 4, let onHowTo {
                    Button {
                        onHowTo()
                    } label: {
                        Text("How to use KIZU?")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.accentColor)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 80)
                    .transition(.opacity)
                    .accessibilityLabel("How to use KIZU")
                    .accessibilityHint("Opens the how to use the app guide")
                }
            }
            .animation(reduceMotion ? .easeInOut(duration: 0.1) : .easeInOut, value: currentPage)
        }
    }
}

// ======================================

struct FirstPageView: View {
    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor.ignoresSafeArea()

            VStack {
                Image("Story1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 300)
                    .accessibilityLabel("An angry boy shouting at his firend")
                Spacer().frame(height: 450)
            }

            Circle()
                .fill(backgroundColor)
                .frame(width: 800, height: 800)
                .offset(y: 400)
                .accessibilityHidden(true)

            VStack {
                Text("Once upon a time, there was a boy who had bad temper..")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 330)
                    .padding(.bottom, 150)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
    }
}

// ======================================
struct SecondPageView: View {
    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor.ignoresSafeArea()

            VStack {
                Image("Story2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 300)
                    .accessibilityLabel("A father giving nails to his son")
                Spacer().frame(height: 450)
            }

            Circle()
                .fill(backgroundColor)
                .frame(width: 800, height: 800)
                .offset(y: 400)
                .accessibilityHidden(true)

            VStack {
                Text("His father gave him some nails and told him to hammer a nail into the fence each time he hurt someone with his anger")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 330)
                    .padding(.bottom, 150)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
    }
}

// ======================================

struct ThirdPageView: View {
    let isActive: Bool
    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)
    private let images = ["Story3_1", "Story3_2", "Story3_3"]
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor.ignoresSafeArea()

            VStack {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 300)
                    .transition(.opacity)
                    .id(currentIndex)
                    .accessibilityLabel("A fence filling up with nails")
                Spacer().frame(height: 450)
            }

            Circle()
                .fill(backgroundColor)
                .frame(width: 800, height: 800)
                .offset(y: 400)
                .accessibilityHidden(true)

            VStack {
                Text("After a while, the fence was full of nails! The boy felt sorry, so he began to apologize to everyone whom he hurt; and for every apology he made, he removed one nail.")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 330)
                    .padding(.bottom, 150)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .onChange(of: isActive) { _, active in
            if active { startTimer() } else { stopTimer(); currentIndex = 0 }
        }
        .onAppear {
            if isActive { startTimer() }
        }
    }

    private func startTimer() {
        guard !reduceMotion else { return }
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// ======================================

struct ForthPageView: View {
    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor.ignoresSafeArea()

            VStack {
                Image("Story4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 300)
                    .accessibilityLabel("A fence with holes left behind after nails were removed")
                Spacer().frame(height: 450)
            }

            Circle()
                .fill(backgroundColor)
                .frame(width: 800, height: 800)
                .offset(y: 400)
                .accessibilityHidden(true)

            VStack {
                Text("When all the nails were gone, his father said, \"Look at the holes. The fence will never be the same. The words you say can leave scars, even after you say sorry.\"")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 330)
                    .padding(.bottom, 150)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
    }
}

// ======================================

struct FifthPageView: View {
    let isActive: Bool
    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)
    private let images = ["Story5_1", "Story5_2"]
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor.ignoresSafeArea()

            VStack {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 300)
                    .transition(.opacity)
                    .id(currentIndex)
                    .accessibilityLabel("The boy reflecting on his lesson")
                Spacer().frame(height: 450)
            }

            Circle()
                .fill(backgroundColor)
                .frame(width: 800, height: 800)
                .offset(y: 400)
                .accessibilityHidden(true)

            VStack {
                Text("The boy never forgot the lesson. The holes in the fence became a permanent reminder that words spoken in anger can wound deeply. Whenever he felt his temper rising, he paused and reflected on the pain his words could cause.")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 330)
                Spacer().frame(height: 125)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .onChange(of: isActive) { _, active in
            if active { startTimer() } else { stopTimer(); currentIndex = 0 }
        }
        .onAppear {
            if isActive { startTimer() }
        }
    }

    private func startTimer() {
        guard !reduceMotion else { return }
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
