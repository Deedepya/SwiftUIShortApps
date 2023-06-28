//
//  EventsListView.swift
//  ListViewApp
//
//  Created by dedeepya reddy salla on 28/06/23.
//

/*
 List {
 //ForEach(Period.allCases) { period in
 Section {
 ForEach(eventVM.events) { event in
 NavigationLink {
 Text(event.title)
 .fontWeight(.bold)
 } label: {
 EventRow(event: event)
 }
 }
 } header: {
 Text("All days shown for now")
 }
 //}
 }.navigationTitle("Date Planner")
 */

import SwiftUI

struct EventsListView: View {
    @StateObject var eventVM = EventsViewModel()
//    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            EventsListViewer()
                .environmentObject(eventVM)
                .navigationTitle("Date Planner")
        }
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
    }
}

struct EventsListViewer: View {
    @EnvironmentObject var eventVm: EventsViewModel
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section {
                ForEach(eventVm.events) { event in
                    NavigationLink {
                        EventDetailView(event: event)
                            .environmentObject(eventVm)
                    } label: {
                        EventRow(event: event)
                    }
                }
            } header: {
                Text("All days shown for now")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }
        }.listStyle(.sidebar)
            .toolbar {
                Button {
                    isPresented = true
                    print("+ button lcicked")
                } label: {
                    Image(systemName: "plus")
                }
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    EventDetailView(event: Event(), isNewEvent: true)
                                .environmentObject(eventVm)
                        }
                }
    }
}

struct EventRow: View {
    @State var event: Event
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: event.symbol)
                .sfSymbolStyling()
            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .fontWeight(.bold)
                Text(event.date.formatted(date: .long, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }.badge(event.tasks.count)
    }
}

struct EventDetailView: View {
    @Environment(\.dismiss) private var dismissView
    @EnvironmentObject var eventVm: EventsViewModel
    @State var event: Event
    var isNewEvent: Bool = false
    
    var body: some View {
        
        List {
            EventRow(event: event)
            Text("Tasks")
                .fontWeight(.bold)
            ForEach($event.tasks) { $task in
                TaskRow(task: $task)
            }
            Button {
                print("clicked on new task")
                event.createNewTask()
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Task")
                }
            }
        }.toolbar {
            if !isNewEvent {

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Save clicked")
                        eventVm.replaceEvent(event: event)
                        dismissView()
                    } label: {
                        Text("Save")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("Delete clicked")
                        eventVm.deleteEvent(event: event)
                        dismissView()
                    } label: {
                        Label("Delete event", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Add clicked")
                        eventVm.addNewEvent(event: event)
                        dismissView()
                    } label: {
                        Text("Add")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("cancel clicked")
                        dismissView()
                    } label: {
                        Text("cancel")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add new Event here")
                }
            }
        }
    }
}

struct TaskRow: View {
    @Binding var task: EventTask
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            Button {
                task.isCompleted.toggle()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
            }.disabled(task.text.isEmpty)
            
            if !task.isNew {
                Text(task.text)
            } else {
                TextField("", text: $task.text, prompt: Text("enter ur task info"))
//                    .focused($isFocused)
//                    .onChange(of: isFocused) { newValue in
//                        isFocused = newValue
//                       // task.isNew = false
//                    }
            }
        }
    }
}

extension View {
    func sfSymbolStyling() -> some View {
        modifier(SFSymbolStyling())
    }
}
