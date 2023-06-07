import SwiftUI

struct Inspector: View {
  @State var isInspectorPresented = false
  
  var body: some View {
    Button("Present Inspector View") {
      isInspectorPresented.toggle()
    }
    .inspector(isPresented: $isInspectorPresented) {
      Text("Inspector view")
    }
  }
}
