import SwiftUI

struct ContentUnavailableViewDemo: View {
  @State var kind: ContentUnavailableViewKind = .withImage
  
  var body: some View {
    TabView(selection: $kind) {
      ForEach(ContentUnavailableViewKind.allCases) { kind in
        switch kind {
        case .withImage:
          ContentUnavailableView("Content unavailable with image", image: "AssetExample").tag(kind)
        case .withSystemImage:
          ContentUnavailableView("Content unavailable with system image", systemImage: "star").tag(kind)
        }
      }
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
}

enum ContentUnavailableViewKind: String, CaseIterable, Identifiable {
  case withImage
  case withSystemImage
  
  var id: String { rawValue }
}
