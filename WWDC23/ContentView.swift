import SwiftUI

struct ContentView: View {
  @State var selectedTopic: Topic?
  
  var body: some View {
    NavigationStack {
      List(Topic.allCases) { topic in
        Button(topic.id) { selectedTopic = topic }
      }
      .navigationTitle("WWDC23 Topics")
    }
    .sheet(item: $selectedTopic) { topic in
      NavigationStack {
        topic
          .buildTopicView()
          .navigationTitle(topic.id)
          .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}

enum Topic: String, CaseIterable, Identifiable {
  case scrollTransition
  case scrollViewPosition
  
  var id: Self.RawValue { rawValue }
}

extension Topic {
  @ViewBuilder
  func buildTopicView() -> some View {
    switch self {
    case .scrollTransition:
      ScrollTransition()
    case .scrollViewPosition:
      ScrollViewPosition()
    }
  }
}
