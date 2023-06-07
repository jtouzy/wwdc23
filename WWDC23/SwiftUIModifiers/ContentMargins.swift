import SwiftUI

struct ContentMargins: View {
  @State var data = FakeItem.build(50)
  
  var body: some View {
    VStack {
      scrollView(axis: .horizontal, paddingAxis: .horizontal)
      scrollView(axis: .vertical, paddingAxis: .vertical)
    }
  }
  
  @ViewBuilder
  func scrollView(axis: Axis.Set, paddingAxis: Edge.Set) -> some View {
    VStack {
      Text("Scroll view with axis \(axis == .horizontal ? "Horizontal" : "Vertical")").font(.footnote)
      ScrollView(axis) {
        scrollViewContent(for: axis)
      }
      // 1: The content margins will add extra margin depending on the axis you give.
      // This extra padding can be seen on before the first and after last element, in those examples.
      // With this you can adjust scroll content separatly from scroll indicators.
      .contentMargins(paddingAxis, 16.0, for: .scrollContent)
    }
    .containerRelativeFrame(.vertical, count: 2, span: 1, spacing: 16.0)
  }
  
  @ViewBuilder
  func scrollViewContent(for axis: Axis.Set) -> some View {
    let content = ForEach(data) { item in
      Text(item.id.description)
        .padding()
        .frame(maxWidth: axis == .horizontal ? nil : .infinity, maxHeight: axis == .vertical ? nil : .infinity)
        .background(Color.red)
    }
    if axis == .horizontal {
      HStack { content }
    } else {
      VStack { content }
    }
  }
}
