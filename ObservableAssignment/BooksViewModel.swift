import SwiftUI

@Observable
class BooksViewModel {
    var books: [BookModel] = []
    
    init() { }
    
    func loadBooks() {
        do {
            books = try fetchBooksFromJSON()
        } catch {
            print(error)
        }
    }
    
    private func fetchBooksFromJSON() throws -> [BookModel] {
        guard let url = Bundle.main.url(forResource: "Book", withExtension: ".json") else {
            throw URLError(.unknown)
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        return try decoder.decode([BookModel].self, from: data)
    }
}
