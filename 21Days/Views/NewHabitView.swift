//
//  NewHabitView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/9/25.
//

import SwiftUI

struct NewHabitView: View {
    @EnvironmentObject var store: HabitStore
    
    @State var title: String = ""
    @FocusState private var isFocused: Bool
    
    let dateStyle = Date.FormatStyle()
        .year(.defaultDigits)
        .month(.twoDigits)
        .day(.twoDigits)
    
    var body: some View {
        NavigationView {
            VStack {
                
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
                            .stroke(Color.black, lineWidth: 2)
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
                
                Divider()
                 
                //Starting and Ending Dates
                HStack {
                    Text("Starting / Completing Dates")
                        .font(.title2)
                        .bold()
                        .padding()
                    Spacer()
                }
                
                //Showing Date.now and 21 days after Date.now
                HStack(spacing: 20) {
                    VStack {
                        Text(Date.now, format: dateStyle)
                        Text(Date.now, format: .dateTime.weekday())
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    
                    VStack {
                        Text("21 Days")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("~")
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack {
                        Text(Date.now.addingTimeInterval(3600 * 24 * 21), format: dateStyle)
                        Text(Date.now.addingTimeInterval(3600 * 24 * 21), format: .dateTime.weekday())
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
                
                
                Spacer()
                
                Button {
                    //new habit adding logic
                    if !title.isEmpty {
                        store.insertNewHabit(title: title, startDate: Date.now)
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
        .environmentObject(HabitStore())
}
