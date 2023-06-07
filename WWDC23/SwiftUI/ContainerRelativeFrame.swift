import SwiftUI

struct ContainerRelativeFrame: View {
  @State var data = FakeItem.build(20)
  
  var body: some View {
    VStack {
      horizontalScrollView(splitScreenInto: 5, splitForOneItem: 2)
      horizontalScrollView(splitScreenInto: 10, splitForOneItem: 2)
    }
    .frame(maxHeight: .infinity, alignment: .top)
  }
  
  @ViewBuilder
  func horizontalScrollView(splitScreenInto count: Int, splitForOneItem span: Int) -> some View {
    VStack {
      headerViewForScrollView(splitCount: count, span: span)
      ScrollView(.horizontal) {
        HStack {
          ForEach(data) { item in
            Text(item.id.description)
              .padding()
              .frame(maxWidth: .infinity)
              .background(Color.red)
              // 1: As the method description says, the count will represent the number of splits that the screen is
              // divided to, and the span will represent the number of visible splits for one item.
              .containerRelativeFrame(.horizontal, count: count, span: span, spacing: 8)
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func headerViewForScrollView(splitCount: Int, span: Int) -> some View {
    Text("Screen is divided in \(splitCount) splits, and a single cell fills \(span) splits.")
      .font(.footnote)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal)
  }
}
