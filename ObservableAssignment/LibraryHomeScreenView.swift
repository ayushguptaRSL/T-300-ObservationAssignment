import SwiftUI

struct LibraryHomeScreenView: View {
    @Environment(BooksViewModel.self) var viewModel
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.books, id: \.title) { book in
                        FlippingBookCard(book: book)
                            .onTapGesture {
                                navigationPath.append(book)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Books")
            .navigationDestination(for: BookModel.self) { book in
                BookDetailView(book: book)
            }
        }
        .task {
            viewModel.loadBooks()
        }
    }
}

#Preview {
    LibraryHomeScreenView()
}
