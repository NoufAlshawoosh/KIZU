//
//  OnboardingPageView.swift
//  KIZU
//
//  Created by Nouf Alshawoosh on 27/02/2026.
//

import SwiftUI

struct OnboardingPageView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var show = false
    @State private var showImage = false
    @State private var showText = false
    @State private var showButton = false
    @State private var showStory = false
    @State private var showHowTo = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    private let backgroundColor = Color(red: 246/255, green: 238/255, blue: 229/255)

    var body: some View {
        ZStack {
            if showHowTo {
                HowToUseAppView(onDismiss: { hasSeenOnboarding = true })
                    .transition(reduceMotion ? .opacity : .move(edge: .trailing))
            } else if showStory {
                StoryView(onHowTo: { withAnimation(reduceMotion ? .easeInOut(duration: 0.1) : .easeInOut(duration: 0.4)) { showHowTo = true } })
                    .transition(reduceMotion ? .opacity : .move(edge: .trailing))
            } else {
                backgroundColor.ignoresSafeArea()

                Circle()
                    .fill(Color.white)
                    .frame(width: 800, height: 800)
                    .offset(y: show ? 300 : 900)
                    .animation(reduceMotion ? .none : .easeOut(duration: 0.8), value: show)
                    .accessibilityHidden(true)

                VStack {
                    Spacer()

                    Image("Onboarding")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 450, height: 300)
                        .opacity(showImage ? 1 : 0)
                        .animation(reduceMotion ? .none : .easeIn(duration: 0.5), value: showImage)
                        .padding(.top, 280)
                        .accessibilityLabel("KIZU app illustration")
                        .accessibilityHidden(!showImage)

                    Spacer()

                    Text("Welcome to KIZU")
                        .font(.title.bold())
                        .foregroundStyle(Color.accentColor)
                        .opacity(showText ? 1 : 0)
                        .animation(reduceMotion ? .none : .easeIn(duration: 0.5), value: showText)
                        .accessibilityAddTraits(.isHeader)

                    Spacer().frame(height: 40)

                    Text("KIZU (傷) is Japanese word means wound.")
                        .font(.body)
                        .foregroundStyle(.black)
                        .opacity(showText ? 1 : 0)
                        .animation(reduceMotion ? .none : .easeIn(duration: 0.5), value: showText)

                    Spacer().frame(height: 15)

                    Text("This name was inspired by an impactful story.")
                        .font(.body)
                        .foregroundStyle(.black)
                        .opacity(showText ? 1 : 0)
                        .animation(reduceMotion ? .none : .easeIn(duration: 0.5), value: showText)

                    Spacer().frame(height: 150)

                    Button {
                        withAnimation(reduceMotion ? .easeInOut(duration: 0.1) : .easeInOut(duration: 0.4)) { showStory = true }
                    } label: {
                        Text("Read the Story")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 100)
                            .background(Color.accentColor)
                            .cornerRadius(30)
                    }
                    .opacity(showButton ? 1 : 0)
                    .animation(reduceMotion ? .none : .easeIn(duration: 0.4), value: showButton)
                    .accessibilityLabel("Read the Story")
                    .accessibilityHint("Opens the story that inspired KIZU")

                    Spacer().frame(height: 200)
                }
            }
        }
        .ignoresSafeArea()
        .animation(reduceMotion ? .easeInOut(duration: 0.1) : .easeInOut(duration: 0.4), value: showStory)
        .animation(reduceMotion ? .easeInOut(duration: 0.1) : .easeInOut(duration: 0.4), value: showHowTo)
        .onAppear {
            if reduceMotion {
                show = true
                showImage = true
                showText = true
                showButton = true
            } else {
                show = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { showImage = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) { showText = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) { showButton = true }
            }
        }
    }
}
