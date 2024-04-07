//
//  DragAndDropSwiftUIView.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 15/3/24.
//

import SwiftUI

// MARK: - Documentation

/*
 SwiftUI VC for drag and drop. The actual Drag and Drop is implemented in the
 .draggable and .dropDestination. Needs redesigning so it looks nice and works better.
 */

struct DragAndDropSwiftUIView: View {
    @State var delegate : DragAndDropViewController
    @State var data : DragAndDropElement
    @State var answers : [String]
    @State var options : [String]
    @State var buttonDisabled = [true, true, true, true, true, true, true, true, true, true, true]
    @State var timer : Int
    @State var isTimed : Bool
    
    
    
    let timerDecrease = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        VStack(alignment: .center, spacing: 30){
            HStack{
                Text("Question 1").frame(alignment: .leading)
                if isTimed {
                    Image(systemName: "timer")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .frame(alignment: .trailing)
                    
                    Text("\(timer)")
                        .onReceive(timerDecrease) { _ in
                            if timer > 0 {
                                timer -= 1
                            } else {
                                // Time ran out
                            }
                        }
                }
            }
            
            // Question Text
            
            VStack(alignment: .center, spacing: 10){
                Text("Drop the Correct Answers Here")
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
                        DropLocation(text: $answers[index], index: index, answers: $answers)
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
    
    struct DropLocation: View {
        @Binding var text: String
        let index: Int
        @Binding var answers: [String]
        
        var body: some View {
            Text("\(text)")
                .padding(12)
                .background(Color("onSelect"))
                .font(.custom("Avenir-Book", size: 17))
                .cornerRadius(8)
                .shadow(radius: 1, x: 1, y: 1)
                .dropDestination(for: String.self){droppedItems,location in
                    self.text = droppedItems.first!
                    self.answers[index] = droppedItems.first!
                    print(answers)
                    return true
                }
        }
    }
    
    func deleteButton(position : Int){
        if !answers[position].contains(". __") {
            //data.question = data.question.replacingOccurrences(of: answers[position], with: "\(position+1). __")
            options.append(answers[position])
            answers[position]="\(position+1). __"
            buttonDisabled[position] = true
        }
    }
    
    
    func nextButton(){
        
        var results : [Int] = []
        
        for i in 0..<answers.count {
            if answers[i].contains(". __") {
                return
            } else {
                results.append(data.options.firstIndex(of: answers[i])!)
            }
        }
        delegate.next(userAnswers: results, timer: timer)
    }
    
    func getText() -> Text {
        var text = Text("")
        for i in 0..<data.question.count {
            if i < answers.count {
                text = text + Text(data.question[i]).font(.custom("Avenir-Book", size: 17)) + Text(answers[i]).font(.custom("Avenir-Heavy", size: 17))
            } else {
                text = text + Text(data.question[i]).font(.custom("Avenir-Book", size: 17))
            }
        }
        return text
    }
}

var data = DragAndDropElement(
    type: .question(type: .dragAndDrop), isTimed: false, timer: 100,
    question:  ["var ", " = 0\n",
                " number in 1...10 {\n",
                " += number\n}\n",
                "(\"The sum of numbers 1 to 10 is: \\(sum)\")"
               ],
    options: ["sum", "if", "for", "print"],
    correctOptions: [0, 2, 0, 3], number: 4)

var emptyAnswers : [String] = ["1. __","2. __","3. __","4. __"]


#Preview {
    DragAndDropSwiftUIView(
        delegate: DragAndDropViewController(),
        data: data,
        answers: emptyAnswers,
        options: data.options, timer: 30, isTimed: false
    )
}
