//
//  EventsViewModel.swift
//  ListViewApp
//
//  Created by dedeepya reddy salla on 28/06/23.
//

import Foundation
import Combine

class EventsViewModel: ObservableObject {
    @Published var events = dummyEvents
    
    /*
     nice concept is hidden here -- so use it for further analysing
     */
    func getNewEvent() -> Event {
        let event = Event(symbol: "facemask.fill", color: .blue, title: "my own event \(events.count + 1)", date: Date())
        events.append(event)
        return event
    }
    
    func addNewEvent(event: Event) {
        events.append(event)
    }
    
    func deleteEvent(event: Event) {
        if let index = getEventIndex(event: event) {
            events.remove(at: index)
        }
    }
    
    func replaceEvent(event: Event) {
        if let index = getEventIndex(event: event) {
            events[index] = event
        }
    }
    func getEventIndex(event: Event) -> Int? {
        return events.firstIndex(where: {$0.id == event.id})
    }
}

let dummyEvents = [
    Event(symbol: "gift.fill",
          color: .red,
          title: "Maya's Birthday",
          tasks: [EventTask(text: "Guava kombucha"),
                  EventTask(text: "Paper cups and plates"),
                  EventTask(text: "Cheese plate"),
                  EventTask(text: "Party poppers"),
                 ],
          date: Date.roundedHoursFromNow(60 * 60 * 24 * 30)),
    Event(symbol: "theatermasks.fill",
          color: .yellow,
          title: "Pagliacci",
          tasks: [EventTask(text: "Buy new tux"),
                  EventTask(text: "Get tickets"),
                  EventTask(text: "Pick up Carmen at the airport and bring her to the show"),
                 ],
          date: Date.roundedHoursFromNow(60 * 60 * 22)),
    Event(symbol: "facemask.fill",
          color: .indigo,
          title: "Doctor's Appointment",
          tasks: [EventTask(text: "Bring medical ID"),
                  EventTask(text: "Record heart rate data"),
                 ],
          date: Date.roundedHoursFromNow(60 * 60 * 24 * 4)),
    Event(symbol: "leaf.fill",
          color: .green,
          title: "Camping Trip",
          tasks: [EventTask(text: "Find a sleeping bag"),
                  EventTask(text: "Bug spray"),
                  EventTask(text: "Paper towels"),
                  EventTask(text: "Food for 4 meals"),
                  EventTask(text: "Straw hat"),
                 ],
          date: Date.roundedHoursFromNow(60 * 60 * 36)),
    Event(symbol: "gamecontroller.fill",
          color: .cyan,
          title: "Game Night",
          tasks: [EventTask(text: "Find a board game to bring"),
                  EventTask(text: "Bring a desert to share"),
                 ],
          date: Date.roundedHoursFromNow(60 * 60 * 24 * 2)),
    Event(symbol: "graduationcap.fill",
          color: .primary,
          title: "First Day of School",
          tasks: [
              EventTask(text: "Notebooks"),
              EventTask(text: "Pencils"),
              EventTask(text: "Binder"),
              EventTask(text: "First day of school outfit"),
          ],
          date: Date.roundedHoursFromNow(60 * 60 * 24 * 365)),
    Event(symbol: "book.fill",
          color: .purple,
          title: "Book Launch",
          tasks: [
              EventTask(text: "Finish first draft"),
              EventTask(text: "Send draft to editor"),
              EventTask(text: "Final read-through"),
          ],
          date: Date.roundedHoursFromNow(60 * 60 * 24 * 365 * 2)),
    Event(symbol: "globe.americas.fill",
          color: .gray,
          title: "WWDC",
          tasks: [
              EventTask(text: "Watch Keynote"),
              EventTask(text: "Watch What's new in SwiftUI"),
              EventTask(text: "Go to DT developer labs"),
              EventTask(text: "Learn about Create ML"),
          ],
          date: Date.from(month: 6, day: 7, year: 2021)),
    Event(symbol: "case.fill",
          color: .orange,
          title: "Sayulita Trip",
          tasks: [
              EventTask(text: "Buy plane tickets"),
              EventTask(text: "Get a new bathing suit"),
              EventTask(text: "Find a hotel room"),
          ],
          date: Date.roundedHoursFromNow(60 * 60 * 24 * 19)),
]
