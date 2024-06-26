//
//  DragAndDropSwiftUIView.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 15/3/24.
//  Redone, Completed by Rohit Anantha on 4/17/24

import SwiftUI

// MARK: - Documentation


/// Swift UI VC that uses the draggable properties to have a drag and drop question
struct DragAndDropSwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    @State var delegate : DragAndDropViewController
    @State var data : DragAndDropElement
    @State var answers: [String] = [] 
    @State var options : [String]
    @State var buttonDisabled = [true, true, true, true, true, true, true, true, true, true, true]
    @State var timer : Int
    @State var isTimed : Bool
    @State var showAlert = false
    var isReview: Bool!
    
    @State var flashColors: [Color?] = []

    var answerIndexes : [Int] = []
    
    let timerDecrease = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    /// Formats a time into mm:ss format
    var formattedTimer: String {
        let minutes = timer / 60
        let seconds = timer % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View{
        VStack(alignment: .center, spacing: 30){
            HStack {
                    Text("Question:")
                        .frame(alignment: .leading)
                        .font(.custom("Avenir-Heavy", size: 17))
                    if isTimed {
                        Image(systemName: "timer")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                            .frame(alignment: .trailing)
                        
                        Text(formattedTimer)
                            .font(.custom("Avenir-Heavy", size: 17))
                            .onReceive(timerDecrease, perform: { _ in
                                if timer > 0 {
                                    timer -= 1
                                } else {
                                    self.showAlert.toggle()
                                    timerDecrease.upstream.connect().cancel()
                                }
                            })
                            .alert(isPresented: $showAlert, content: {
                                Alert(title: Text("Oh no!"), message: Text("Seems like you ran out of time... You will be taken back to the roadmap with a penalty."), dismissButton: .default(Text("Ok"), action: {
                                        Task { await self.delegate.decreaseScore() }
                                        self.delegate.userRanOutOfTime()
                                        dismiss()
                                }))
                            })
                    }
                }
            // Question Text
            
            VStack(alignment: .center, spacing: 10){
                Text("Drop the Correct Answers in the Blanks")
                    .padding()
                    .font(.custom("Avenir-Heavy", size: 17))
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(.secondarySystemFill)))
                getText()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(.secondarySystemFill)))
                
            }
            
            // drop locations
            
            VStack(alignment: .center, spacing: 10){
                Text("Blank Spaces").font(.custom("Avenir-Heavy", size: 19))
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                    ForEach(0..<answers.count, id: \.self) { index in
                        let dropLocation = DropLocation(text: $answers[index], index: index, answers: $answers, flashColor: $flashColors[index], isReview: isReview, options: options)
                        dropLocation
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color(.secondarySystemFill)))
            }
            
            // answer choices
            VStack(alignment: .center, spacing: 10){
                Text("Options").font(.custom("Avenir-Heavy", size: 19))
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .padding(12)
                            .background(Color(.secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .font(.custom("Avenir-Book", size: 17))
                            .shadow(radius: 1, x: 1, y: 1)
                            .draggable(option)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color(.secondarySystemFill)))
                
                // next button
                Button("Next", action: nextButton)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color("onSelect"))
                            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 5, y: 5)
                    )
                    .foregroundColor(Color("textColor"))
                    .font(Font.custom("Avenir-Book", size: 17))
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
    
    
    /// A location to drop a dragged object
    /// automatically updates color using the flashcolor object
    /// updates a certain position in the answers array with the answer dropped on it
    struct DropLocation: View {
        @Binding var text: String
        let index: Int
        @Binding var answers: [String]
        @Binding var flashColor: Color?
        var isReview: Bool!
        var options: [String]!
        
        var body: some View {
            Text("\(text)")
                .padding(12)
                .background(flashColor.animation(.easeInOut(duration: 0.5)))
                .font(.custom("Avenir-Book", size: 17))
                .cornerRadius(8)
                .shadow(radius: 1, x: 1, y: 1)
                .dropDestination(for: String.self){droppedItems,location in
                    if !isReview {
                        self.text = droppedItems.first!
                        self.answers[index] = droppedItems.first!
                        
                        print(answers)
                    }
                    return true
                }
                .onAppear {
                    print("On Appear")
                    if isReview {
                        self.text = self.options[index]
                        self.answers[index] = self.options[index]
                    }
                }
        }
    }

    
    /// Moves to the next page if all the answer boxes have been filled.
    func nextButton(){
        
        var results : [Int] = []
        
        for i in 0..<answers.count {
            if answers[i].contains(". __") {
                return
            } else {
                results.append(data.options.firstIndex(of: answers[i])!)
            }
        }
        
        for index in 0..<flashColors.count{
            flashColors[index] = data.correctAnswers[index] == options.firstIndex(of: answers[index])  ? Color("correctAnswer") : Color("wrongAnswer")
            print(data.correctAnswers, options, answers[index], options.firstIndex(of: answers[index]) ?? 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                delegate.next(userAnswers: results, timer: timer)
        }
    }
    
    
    /// Formats a question and it's answers into a displayable single Text element
    /// - Returns: returns a Text object that is formatted to automatically update when we drag and drop later
    func getText() -> Text {
        var text = Text("")
        for i in 0..<data.question.count {
            if i < answers.count {
                text = text + Text(data.question[i]).font(.custom("Avenir-Book", size: 17)) + Text(answers[i]).font(.custom("Avenir-Heavy", size: 17))
            } else {
                text = text + Text(data.question[i]).font(.custom("Avenir-Book", size: 17))
            }
        }
        if data.question.count < answers.count {
            for i in data.question.count ..< answers.count {
                text = text + Text("\n").font(.custom("Avenir-Book", size: 17)) + Text(answers[i]).font(.custom("Avenir-Heavy", size: 17))
            }
        }
        return text
    }
}
