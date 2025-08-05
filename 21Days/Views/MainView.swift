//
//  MainView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: HabitStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("OnGoing Habit")) {
                    List(store.habits.filter { $0.isDone == false}) { habit in
                        NavigationLink {
                            DetailedHabitView()
                        } label: {
                            HabitCellView(habit: habit)
                        }
                    }
                }
                
                Section(header: Text("Completed Habit")) {
                    List(store.habits.filter { $0.isDone == true}) { habit in
                        NavigationLink {
                            DetailedHabitView()
                        } label: {
                            HabitCellView(habit: habit)
                        }
                    }
                }
            }
            .navigationTitle("My Habits")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button { } label: { Image(systemName: "plus")}
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button { } label: { Image(systemName: "plus")}
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(HabitStore())
}
