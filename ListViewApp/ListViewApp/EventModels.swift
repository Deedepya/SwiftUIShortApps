//
//  EventModels.swift
//  ListViewApp
//
//  Created by dedeepya reddy salla on 28/06/23.
//

import SwiftUI

struct Event: Identifiable, Hashable {
    let id = UUID()
    let symbol: String
    let color: Color
    let title: String
    var tasks: [EventTask]
    let date: Date
    
    init(symbol: String = "", color: Color = .blue, title: String = "my new event", tasks: [EventTask] = [EventTask()], date: Date = Date()) {
        self.symbol = symbol
        self.color = color
        self.title = title
        self.tasks = tasks
        self.date = date
    }
    
    mutating func createNewTask() {
        self.tasks.append(EventTask())
    }
}

struct EventTask: Identifiable, Hashable {
    let id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
    
    init(text: String = "", isNew: Bool = true) {
        self.text = text
        self.isNew = isNew
    }
}

enum Period: String, CaseIterable, Identifiable {
    case nextSevenDays = "Next 7 Days"
    case nextThirtyDays = "Next 30 Days"
    case future = "Future"
    case past = "Past"
    
    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

struct SFSymbolStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .symbolRenderingMode(.multicolor)
    }
}

struct EventSymbols {
  
    static func randomName() -> String {
        if let symbol = symbolNames.randomElement() {
            return symbol
        } else {
            return ""
        }
    }
    
    static func randomNames(_ number: Int) -> [String] {
        var symbols: [String] = []
        for _ in 0..<number {
            symbols.append(randomName())
        }
        return symbols
    }
    
    static var symbolNames: [String] =
    [
        "house.fill",
        "ticket.fill",
        "gamecontroller.fill",
        "theatermasks.fill",
        "ladybug.fill",
        "books.vertical.fill",
        "moon.zzz.fill",
        "umbrella.fill",
        "paintbrush.pointed.fill",
        "leaf.fill",
        "globe.americas.fill",
        "clock.fill",
        "building.2.fill",
        "gift.fill",
        "graduationcap.fill",
        "heart.rectangle.fill",
        "phone.bubble.left.fill",
        "cloud.rain.fill",
        "building.columns.fill",
        "mic.circle.fill",
        "comb.fill",
        "person.3.fill",
        "bell.fill",
        "hammer.fill",
        "star.fill",
        "crown.fill",
        "briefcase.fill",
        "speaker.wave.3.fill",
        "tshirt.fill",
        "tag.fill",
        "airplane",
        "pawprint.fill",
        "case.fill",
        "creditcard.fill",
        "infinity.circle.fill",
        "dice.fill",
        "heart.fill",
        "camera.fill",
        "bicycle",
        "radio.fill",
        "car.fill",
        "flag.fill",
        "map.fill",
        "figure.wave",
        "mappin.and.ellipse",
        "facemask.fill",
        "eyeglasses",
        "tram.fill",
    ]
}
