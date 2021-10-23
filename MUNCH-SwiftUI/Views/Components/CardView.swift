//
//  CardView.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI

struct CardView: View {
    @State var recipe: Recipe
    @State var isPresented: Bool = false
    @State var selectedRecipe: Recipe?
    // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])

    var body: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: recipe.image != nil ? recipe.image as! String : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg")!,
                       placeholder: { Text("Loading ...") },
                       image: { Image(uiImage: $0).resizable() })
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width * 0.7, height: UIScreen.main.bounds.size.height * 0.81)


            // Linear Gradient
//            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            VStack {
                Spacer()
                VStack(alignment: .leading){
                    HStack {
                        Text(recipe.title).font(.largeTitle).fontWeight(.bold)
                    }
                    Text("Ready in \(recipe.readyInMinutes) minutes").font(.body)
                }
            }
            .padding()
            .foregroundColor(.white)

            HStack {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:150)
                    .opacity(Double(recipe.x/10 - 1))
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:150)
                    .opacity(Double(recipe.x/10 * -1 - 1))
            }

        }

        .cornerRadius(8)
        .offset(x: recipe.x, y: recipe.y)
        .rotationEffect(.init(degrees: recipe.degree))
        .sheet(isPresented: $isPresented) {
            DetailsView(recipe: recipe)
        }
//        .sheet(item: $selectedRecipe, content: { item in
//            DetailsView(recipe: item)
//        })
        .onTapGesture() {
            isPresented = true
//            selectedRecipe = recipe
            print("TITLE: \(recipe.title)")
        }

        .gesture (
            DragGesture()
                .onChanged { value in
                    withAnimation(.default) {
                        recipe.x = value.translation.width
                        // MARK: - BUG 5
                        recipe.y = value.translation.height
                        recipe.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }
                .onEnded { (value) in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                        case 0...100:
                            recipe.x = 0; recipe.degree = 0; recipe.y = 0
                        case let x where x > 100:
                            recipe.x = 500; recipe.degree = 12
                        case (-100)...(-1):
                            recipe.x = 0; recipe.degree = 0; recipe.y = 0
                        case let x where x < -100:
                            recipe.x  = -500; recipe.degree = -12
                        default:
                            recipe.x = 0; recipe.y = 0
                        }
                    }
                }
        )
    }
}
