import SwiftUI

struct ScrollTransition: View {
  @State var data = FakeItem.build(50)
  
  var body: some View {
    ScrollView {
      ForEach(data) { item in
        Text(item.id.description)
          .padding()
          .frame(maxWidth: .infinity)
          .scrollTransition { content, phase in
            // 1: When items are appearing during the scroll, they will become bigger, non-opaque, and will rotate.
            // You can see them appearing in the scroll view bottom or disappearing on top.
            content
              .scaleEffect(phase.isIdentity ? 2 : 0.5)
              .opacity(phase.isIdentity ? 1 : 0)
              .rotationEffect(.degrees(phase.isIdentity ? 0 : 90))
          }
      }
    }
  }
}
