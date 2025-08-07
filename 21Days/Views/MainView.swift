//
//  MainView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var habit: Habit
    @EnvironmentObject var store: HabitStore

    var body: some View {
        TabView {
            NavigationView {
                Form {
                    Section(header: Text("OnGoing Habit")) {
                        List(store.habits.filter { !$0.isDone }) { habit in
                            NavigationLink {
                                DetailedHabitView(habit: habit)
                            } label: {
                                HabitCellView(habit: habit)
                            }
                        }
                    }

                    Section(header: Text("Completed Habit")) {
                        List(store.habits.filter { $0.isDone }) { habit in
                            NavigationLink {
                                DetailedHabitView(habit: habit)
                            } label: {
                                HabitCellView(habit: habit)
                            }
                        }
                    }
                }
                .navigationTitle("My Habits")
            }
            .tabItem {
                Label("Habits", systemImage: "list.bullet")
            }

            DetailedHabitView(habit: habit)
                .tabItem {
                    Label("Other", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    MainView(habit: Habit(title: "Test", isDone: false))
        .environmentObject(HabitStore())
}
