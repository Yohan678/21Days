//
//  NewHabitView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/9/25.
//

import SwiftUI
import SwiftData

struct NewHabitView: View {
//    @EnvironmentObject var store: HabitStore
    @Environment(\.modelContext) private var modelContext
    
    
    @State var title: String = ""
    @FocusState private var isFocused: Bool
    
    let dateStyle = Date.FormatStyle()
        .year(.defaultDigits)
        .month(.twoDigits)
        .day(.twoDigits)
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                
                Text("Date: \(Date.now, style: .date)")
                    .padding()
                
                //Habit Name
                HStack {
                    Text("Habit Name")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
                
                TextField("e.g., Daily Meditation", text: $title)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding()
                    .focused($isFocused)
                
                //text erase button
                if !title.isEmpty {
                    Button {
                        title = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.tertiary)
                    }
                    .buttonStyle(.plain)
                    .padding()
                }
                
                
                
                Spacer()
                
                Button {
                    //new habit adding logic
                    if !title.isEmpty {
                        let newHabit = Habit(title: title, isDone: false, startDate: Date.now)
                        modelContext.insert(newHabit)
                        title = ""
                    }
                } label: {
                    Text("Add Habit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(14)
                        .padding()
                }
            }
            .navigationTitle("Add New Habit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewHabitView()
        .modelContainer(for: Habit.self, inMemory: true)
}
