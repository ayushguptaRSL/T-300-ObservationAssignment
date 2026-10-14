import SwiftUI

struct FlippingBookCard: View {
    var book: BookModel
    @State private var isFlipped = false

    var body: some View {
        ZStack {
            VStack {
                Image(book.imageLink)
                    .resizable()
                    .clipShape(.rect(cornerRadius: 8))
                
                Text(book.title)
                    .font(.title3)
                    .bold()
                    .lineLimit(2)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 4)
                    .multilineTextAlignment(.center)
            }
            .opacity(isFlipped ? 0 : 1)

            VStack(spacing: 8) {
                Text("Details")
                    .font(.headline)
                    .bold()

                Text("**Author:** \(book.author)")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)

                Text("**Year:** \(book.year, format: .number.grouping(.never))")
                    .font(.subheadline)

                Text("**Language:** \(book.language)")
                    .font(.subheadline)
                
                Text("**Page Count:** \(book.pages)")
                    .font(.subheadline)
            }
            .padding(8)
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .opacity(isFlipped ? 1 : 0)
        }
        .frame(height: 300)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.5), lineWidth: 2)
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .onLongPressGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isFlipped.toggle()
            }
        }
    }
}
