import SwiftUI
import Observation

struct BookEditorView: View {
    @Environment(BooksViewModel.self) var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var draft: BookModel

    init(existingBook: BookModel) {
        self.draft = existingBook
    }

    var body: some View {
        NavigationStack {
            Form {
                BookFormFieldsView(book: draft)
            }
            .navigationTitle("Edit Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

private struct BookFormFieldsView: View {
    @Bindable var book: BookModel
    @State private var isTitleChanged: Bool = false

    var body: some View {
        Section("Book details") {
            TextField("Title", text: $book.title)
            TextField("Author", text: $book.author)
            TextField("Language", text: $book.language)
            TextField("Country", text: $book.country)
            Stepper("Publication year: \(book.year)", value: $book.year, in: -3000...2100)
            Stepper("Pages: \(book.pages)", value: $book.pages, in: 1...5000)
        }
        .onAppear {
            observeValue()
        }
        .alert("Book Title has been Changed!", isPresented: $isTitleChanged) {
            Button("Close", role: .cancel) { }
        }
    }
    
    func observeValue() {
        withObservationTracking {
            print(book.title)
        } onChange: {
            // Re-register to keep tracking continuously
            Task { @MainActor in
                isTitleChanged.toggle()
                observeValue()
            }
        }
    }
}
