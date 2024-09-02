import SwiftUI
import SwiftData

@main
struct SwiftBitesApp: App {
    // Initialize a ModelContainer with the defined models
//    @State private var container: ModelContainer = {
//        try! ModelContainer(for: Category.self, Ingredient.self, Recipe.self, RecipeIngredient.self)
//    }()
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .modelContainer(container)
//        }
//    }
    
    
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: Category.self, Ingredient.self, Recipe.self, RecipeIngredient.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
    
}
