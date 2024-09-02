import SwiftUI
import SwiftData

struct IngredientForm: View {
    enum Mode: Hashable {
        case add
        case edit(Ingredient)
    }
    var mode: Mode
    
    // MARK: - Initialization
    init(mode: Mode) {
        self.mode = mode
        switch mode {
        case .add:
            _name = .init(initialValue: "")
            title = "Add Ingredient"
        case .edit(let ingredient):
            _name = .init(initialValue: ingredient.name)
            title = "Edit \(ingredient.name)"
        }
    }
    
    @State private var name: String
    private let title: String
    @State private var error: Error?
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isNameFocused: Bool
    
    // MARK: - Body
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .focused($isNameFocused)
            }
            if case .edit(let ingredient) = mode {
                Button(
                    role: .destructive,
                    action: {
                        delete(ingredient: ingredient)
                    },
                    label: {
                        Text("Delete Ingredient")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                )
            }
        }
        .onAppear {
            isNameFocused = true
        }
        .onSubmit {
            save()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
                    .disabled(name.isEmpty)
            }
        }
    }
    
    //MARK: - Data
    private func delete(ingredient: Ingredient) {
        modelContext.delete(ingredient)
        dismiss()
    }
    
    private func save() {
        switch mode {
        case .add:
            //add new ingredient
            
            let ingredientId = UUID()
            
            let newIngredient = Ingredient(id: ingredientId, name: name)
            modelContext.insert(newIngredient)
        case .edit(let ingredient):
            //update
            ingredient.name = name
        }
        dismiss()
    }
    
}
