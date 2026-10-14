import SwiftUI

@Observable
class BookModel: Codable, Identifiable, Hashable {
    @ObservationIgnored var id: Int
    var author: String
    var country: String
    var imageLink: String
    var language: String
    var title: String
    var description: String
    var pages: Int
    var year: Int

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case country
        case imageLink
        case language
        case title
        case description
        case pages
        case year
    }

    init(id: Int, author: String, country: String, imageLink: String, language: String, title: String, description: String, pages: Int, year: Int) {
        self.id = id
        self.author = author
        self.country = country
        self.imageLink = imageLink
        self.language = language
        self.title = title
        self.description = description
        self.pages = pages
        self.year = year
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.country = try container.decode(String.self, forKey: .country)
        self.imageLink = try container.decode(String.self, forKey: .imageLink)
        self.language = try container.decode(String.self, forKey: .language)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.pages = try container.decode(Int.self, forKey: .pages)
        self.year = try container.decode(Int.self, forKey: .year)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(country, forKey: .country)
        try container.encode(imageLink, forKey: .imageLink)
        try container.encode(language, forKey: .language)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(pages, forKey: .pages)
        try container.encode(year, forKey: .year)
    }

    static func == (lhs: BookModel, rhs: BookModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
