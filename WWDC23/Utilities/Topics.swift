import SwiftUI

// List of all topic sections
enum TopicSection: String, CaseIterable, Identifiable {
  case swiftUIModifiers = "SwiftUI modifiers"
  case swiftUIViews = "SwiftUI views"
  
  var id: Self.RawValue { rawValue }
  var topics: [ConcreteTopic] {
    switch self {
    case .swiftUIModifiers:
      SwiftUIModifiersTopic.allCases.concrete()
    case .swiftUIViews:
      SwiftUIViewsTopic.allCases.concrete()
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

// Topic: SwiftUI Modifiers
enum SwiftUIModifiersTopic: String, Topic, CaseIterable {
  case containerRelativeFrame
  case contentMargins
  case inspector
  case safeAreaPadding
  case scrollTransition
  case scrollViewPosition
}
extension SwiftUIModifiersTopic {
  @ViewBuilder
  func buildTopicView() -> some View {
    switch self {
    case .containerRelativeFrame:
      ContainerRelativeFrame()
    case .contentMargins:
      ContentMargins()
    case .inspector:
      Inspector()
    case .safeAreaPadding:
      SafeAreaPadding()
    case .scrollTransition:
      ScrollTransition()
    case .scrollViewPosition:
      ScrollViewPosition()
    }
  }
}

// Topic: SwiftUI Views
enum SwiftUIViewsTopic: String, Topic, CaseIterable {
  case contentUnavailableView = "ContentUnavailableView"
}
extension SwiftUIViewsTopic {
  @ViewBuilder
  func buildTopicView() -> some View {
    switch self {
    case .contentUnavailableView:
      ContentUnavailableViewDemo()
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
