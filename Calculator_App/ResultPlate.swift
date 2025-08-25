import SwiftUI

struct ResultPlate: View {
    let text: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Tokens.corner, style: .continuous)
                .fill(Color.black)

            
            Text(text)
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .minimumScaleFactor(0.4)
                .lineLimit(1)
            
        }
        .frame(height: Tokens.plateH)
        .padding(.horizontal, Tokens.platePadding)
    }
}
