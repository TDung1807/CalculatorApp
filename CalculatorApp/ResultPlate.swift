import SwiftUI

struct ResultPlate: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 48, weight: .medium, design: .rounded))
            .foregroundStyle(Color.white)
            .minimumScaleFactor(0.4)
            .lineLimit(1)
            .padding(.horizontal, Tokens.platePadding)
            .frame(height: Tokens.plateH)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: Tokens.corner, style: .continuous))
    }
}
