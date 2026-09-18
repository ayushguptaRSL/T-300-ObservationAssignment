import SwiftUI

struct BookDetailView: View {
    let book: BookModel
    @State var isEditing: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(spacing: 16) {
                    Image(book.imageLink)
                        .resizable()
                        .frame(width: 160, height: 240)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)

                    VStack(spacing: 6) {
                        Text(book.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text(book.author)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)

                HStack(spacing: 0) {
                    StatBoxView(title: "Pages", value: "\(book.pages)")
                    Divider().frame(height: 35)
                    StatBoxView(title: "Language", value: book.language)
                    Divider().frame(height: 35)
                    StatBoxView(title: "Year", value: "\(book.year)")
                }
                .padding(.vertical, 8)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                HStack {
                    Text("Country of Origin")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(book.country)
                        .fontWeight(.medium)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Synopsis")
                        .font(.headline)
                    
                    Text(book.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
                .padding(.top, 8)
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem {
                Button("Edit") {
                    isEditing.toggle()
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            BookEditorView(existingBook: book)
        }
    }
}

private struct StatBoxView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationView {
        BookDetailView(
            book: BookModel(
                id: 1,
                author: "George Orwell",
                country: "United Kingdom",
                imageLink: "things-fall-apart",
                language: "English",
                title: "Nineteen Eighty-Four",
                description: "Among the seminal texts of the 20th century, Nineteen Eighty-Four is a rare work that grows more haunting as its futuristic purgatory becomes more real.",
                pages: 328,
                year: 1949
            )
        )
    }
}
