import SwiftUI

// List of all topic sections
enum TopicSection: String, CaseIterable, Identifiable {
  case swiftUIModifiers = "SwiftUI modifiers"
  
  var id: Self.RawValue { rawValue }
  var topics: [ConcreteTopic] {
    switch self {
    case .swiftUIModifiers:
      SwiftUITopic.allCases.concrete()
    }
  }
}

// A protocol to define a topic, for a better modeling API grouping topics by sections using enums
protocol Topic {
  typealias ID = String
  var id: ID { get }
  associatedtype TopicView: View
  func buildTopicView() -> TopicView
}
extension Topic where Self: RawRepresentable, RawValue == String {
  var id: RawValue { rawValue }
}

// Topic: SwiftUI
enum SwiftUITopic: String, Topic, CaseIterable {
  case containerRelativeFrame
  case inspector
  case scrollTransition
  case scrollViewPosition
}
extension SwiftUITopic {
  @ViewBuilder
  func buildTopicView() -> some View {
    switch self {
    case .containerRelativeFrame:
      ContainerRelativeFrame()
    case .inspector:
      Inspector()
    case .scrollTransition:
      ScrollTransition()
    case .scrollViewPosition:
      ScrollViewPosition()
    }
  }
}

// A concrete topic to allow Topic type to be Identifiable when iterating in SwiftUI views
struct ConcreteTopic: Identifiable {
  let topic: any Topic
  var id: Topic.ID { topic.id }
}
extension Array where Element: Topic {
  func concrete() -> [ConcreteTopic] {
    map { .init(topic: $0) }
  }
}
