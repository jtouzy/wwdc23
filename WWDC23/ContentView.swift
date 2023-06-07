import SwiftUI

struct ContentView: View {
  @State var sections = TopicSection.allCases
  @State var selectedConcreteTopic: ConcreteTopic?
  
  var body: some View {
    NavigationStack {
      List(sections) { section in
        Section(section.id) {
          ForEach(section.topics) { concreteTopic in
            HStack {
              Image(systemName: "swift").foregroundStyle(Color.blue).symbolEffect(.pulse)
              Button("\(concreteTopic.id)") { selectedConcreteTopic = concreteTopic }
            }
          }
        }
      }
      .navigationTitle("WWDC23 Topics")
    }
    .sheet(item: $selectedConcreteTopic) { selectedConcreteTopic in
      NavigationStack {
        // NOTE: Quick and dirty way to display any dynamic View here, as we don't care about global state and
        // global view redraw, and it's in a dedicated sheet context, nevermind of using the AnyView demon here
        AnyView(
          selectedConcreteTopic.topic.buildTopicView()
        )
        .navigationTitle(selectedConcreteTopic.id)
        .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}
