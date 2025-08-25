import SwiftUI

enum Tokens {
    static let gap: CGFloat = 8
    static let corner: CGFloat = 12
    static let keyMinH: CGFloat = 64
    static let plateH: CGFloat = 96
    static let platePadding: CGFloat = 24
}

extension Color {
    // Nền trắng
    static let appBG = Color.black
    // Phím số: đen
    static let keyPrimary = Color.gray.opacity(0.5)
    
    static let keyUtility = Color.gray
    
    static let keyOp = Color.orange
 
    static let keyDestructive = Color.gray
  
    static let keyEquals = Color.orange
    
    static let textOnDark = Color.white
  
    static let plateBG = Color.black
    
    static let plateText = Color.white
}
