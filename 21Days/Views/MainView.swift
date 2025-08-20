//
//  MainView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI
import SwiftData
import UserNotifications

struct MainView: View {
//    @ObservedObject var habit: Habit
//    @EnvironmentObject var store: HabitStore
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Habit.startDate, order: .reverse) private var habits: [Habit]
    
    var habit: Habit
    
    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                    Form {
                        Section(header: Text("OnGoing Habit").font(.caption)) {
                            List(habits.filter { !$0.isDone }) { habit in
                                NavigationLink {
                                    DetailedHabitView(habit: habit)
                                } label: {
                                    HabitCellView(habit: habit)
                                }
                            }
                        }
                        
                        Section(header: Text("Completed Habit")) {
                            List(habits.filter { $0.isDone }) { habit in
                                NavigationLink {
                                    DetailedHabitView(habit: habit)
                                } label: {
                                    HabitCellView(habit: habit)
                                }
                            }
                        }
                    }
                    .navigationTitle("My Habits")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label("Habits", systemImage: "list.bullet")
                }
                
                NewHabitView()
                    .tabItem {
                        Label("New", systemImage: "plus")
                    }
            }
        }
        .onAppear {
            //asking for permission for notification
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("Alert Permission given")
                } else if let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    MainView(habit: Habit(title: "Dummy Title", isDone: false))
        .modelContainer(for: Habit.self, inMemory: true)
}
