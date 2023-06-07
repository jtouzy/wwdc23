import SwiftUI

struct FakeItem: Identifiable {
  let id: Int
  
  static func build(_ numberOfItems: Int) -> [Self] {
    (0..<numberOfItems).map { FakeItem(id: $0) }
  }
}
