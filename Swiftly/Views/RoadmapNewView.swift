//
//  RoadmapNewView.swift
//  Swiftly
//
//  Created by Eder Martinez on 2/28/24.
//

import SwiftUI

struct RoadmapNewView: View {
    
    // Total amount of lessons
    // Is an int because no lessons yet
    var circleCount = 34
    
    // Lesson user is currently on
    var currLesson = 22
    
    
    @State private var lessonNumber: Int?
    @State private var alertBool = false
    private var theme: Color = .green

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(1...circleCount, id: \.self) { circlePos in
                        let button = Button(action: {
                            if circlePos <= currLesson {
                                lessonNumber = circlePos
                            } else {
                                alertBool = true
                                print("Hello")
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(theme)
                                    .frame(width: 100)
                                if circlePos > currLesson {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: 100, height: 100)
                            .padding(.top, 20)
                        }
                        if circlePos % 2 == 1 {
                            HStack {
                                Spacer()
                                button
                                Spacer()
                            }
                        } else if circlePos % 4 == 0 {
                            HStack {
                                button
                                Spacer()
                            }
                        } else if circlePos % 4 != 0 {
                            HStack {
                                Spacer()
                                button
                            }
                        }
                    }
                    .navigationDestination(item: $lessonNumber) { lesson in
                        NextRepresentedViewController()
//                        QuestionView(lesson: "Lesson \(lesson)")
                    }
                }
                .padding()
            }
            .navigationTitle("Your Progress")
            .alert("Content Locked", isPresented: $alertBool) {
                Button("Next Lesson") {
                    // LessonNumber's value is changed triggering the navigationDestination
                    lessonNumber = currLesson
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Please complete previous lessons.")
            }
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabView {
        RoadmapNewView()
            .tabItem {
                Label("Roadmap", systemImage: "map.fill")
            }
        Text("Hello, world!")
            .tabItem {
                Label("Welcome", systemImage: "text.bubble")
            }
        List(["John", "Shawn", "Dave", "Dave"], id: \.self) { name in
            HStack {
                Label(name, systemImage: "trophy.fill")
                Spacer()
                Text("5xp")
            }
        }
            .tabItem {
                Label("Leaderboard", systemImage: "trophy.fill")
            }
        Text("Settings")
            .tabItem {
                Label("Settings", systemImage: "person")
            }
    }
}
