import SwiftUI

struct ScrollViewPosition: View {
  @State var data = FakeItem.build(50)
  @State var scrollPosition: FakeItem.ID?
  
  var body: some View {
    VStack {
      headerView()
      ScrollView {
        VStack {
          ForEach(data) { item in
            Text(item.id.description)
              .padding()
              .frame(maxWidth: .infinity)
          }
        }
        // 1: You define the scroll target to inspect
        .scrollTargetLayout()
      }
      // 2: You bind a piece of state with the scroll position to observe it
      .scrollPosition(id: $scrollPosition)
    }
  }
  
  @ViewBuilder
  func headerView() -> some View {
    HStack {
      // 3: You can inspect which element is currently displayed with the scroll
      Text("Scroll position [\(scrollPosition?.description ?? "nil")]")
      Spacer()
      // 4: You trigger a scroll update, giving an item ID as a position
      Button("Scroll to 20") { scrollPosition = 20 }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(RoundedRectangle(cornerRadius: 16).fill(.indigo))
    .padding()
  }
}
