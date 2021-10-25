//
//  RecipesList.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/23/21.
//

import Foundation
import SwiftUI
import CoreData

//MARK: - Shows users' list of recipes that they bookmarked
struct RecipesList: View {
    
    // Core Data
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)])
    var recipeData: FetchedResults<Item>
    
    @State var details: Recipe?     // contains details of selected recipe
    @State var trash: Bool = false  // displays trash can to delete a recipe
    @Binding var isPresented: Bool  // shows modal sheet
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                ForEach(recipeData, id: \.self) { recipe in
                    
                    ZStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(recipe.title!)
                                    .font(.subheadline)
                                    .bold()
                                
                                Text("Ready in \(String(describing: recipe.readyInMinutes ?? "")) minutes")
                                    .font(.subheadline)
                            }.padding(.leading, 20)
                            
                            Spacer()
                            
                            AsyncImage(url: URL(string: recipe.image != nil ? recipe.image! : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg")!,
                                       placeholder: { Text("Loading ...") },
                                       image: { Image(uiImage: $0).resizable() })
                                .frame(width: UIScreen.main.bounds.size.width * 0.25, height: UIScreen.main.bounds.size.height * 0.1)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(5)
                                .padding(15)
                        }
                        
                        .frame(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.13)
                        .background(Color(UIColor.systemGray6))
                        .foregroundColor(.black)
                        .cornerRadius(7)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 3)
                        
                        // Button to delete recipe is revealed when user does long press gesture
                        if trash {
                            HStack {
                                Spacer()
                                VStack {
                                    DeleteButton(recipe: recipe)
                                    Spacer()
                                }
                                .padding(.trailing, 17)
                                .padding(.top, 10)
                            }
                        }
                    }
                    .onTapGesture {
                        isPresented = true
                        
                        // API call to get details of a selected recipe
                        ViewModel().getDetails(for: recipe.id!) { (details) in
                            self.details = details
                        }
                    }
                    .onLongPressGesture() {
                        trash.toggle()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
        }
        .sheet(isPresented: $isPresented) {
            if details != nil {
                DetailsView(recipe: details!)
            } else {
                Text("No details to display.")
            }
        }
    }
}

//MARK: - Button to delete recipe
struct DeleteButton: View {
    
    @Environment(\.managedObjectContext) var context
    var recipe: Item
    
    var body: some View {
        
        Button(action: {
            print("DELETE \(String(describing: recipe.title!))")
            context.delete(recipe)
            try? context.save()
        }, label: {
            Image(systemName: "trash")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .padding(.all, 8)
                .background(Color.red)
                .clipShape(Circle())
                .frame(width: 10, height: 10)
        })
    }
}
