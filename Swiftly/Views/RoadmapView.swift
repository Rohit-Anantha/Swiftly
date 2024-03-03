//
//  RoadmapView.swift
//  Swiftly
//
//  Created by Eder Martinez on 2/28/24.
//

import SwiftUI

let titles = ["Introduction", "Variables", "Operators"]
let lessons = [1, 2, 3, 4, 5, 6, 7]

struct RoadmapView: View {
    var body: some View {
        NavigationStack {
            List(titles, id: \.self) { title in
                Section(title) {
                    ForEach(lessons, id: \.self) { lesson in
                        NavigationLink("Lessons \(lesson)") {
                            QuestionView(lesson: String(lesson))
                        }
                    }
                }
            }
            .navigationTitle("Roadmap")
            
        }
        
    }
}

#Preview {
    RoadmapView()
}
