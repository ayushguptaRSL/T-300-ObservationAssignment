import SwiftUI

@main
struct ObservableAssignmentApp: App {
    @State var viewModel: BooksViewModel = BooksViewModel()

    var body: some Scene {
        WindowGroup {
            LibraryHomeScreenView()
                .environment(viewModel)
        }
    }
}
