//
//  BookViews.swift
//  ReadMe
//
//  Created by Guilherme de Carvalho Correa on 24/04/23.
//

import SwiftUI

struct TitleAndAuthorStack: View {
  let book: Book
  let titleFont: Font
  let authorFont: Font
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(book.title)
        .font(titleFont)
      Text(book.author)
        .font(authorFont)
        .foregroundColor(.secondary)
    }
  }
}

extension Book {
  struct Image: View {
    let image: SwiftUI.Image?
    let title: String
    var size: CGFloat?
    let cornerRadius: CGFloat
    
    var body: some View {
      if let image = image {
        image
                 .resizable()
                 .scaledToFill()
                 .frame(width: size, height: size)
                 .cornerRadius(cornerRadius)
      } else {
        let symbol = SwiftUI.Image(title: title) ?? .init(systemName: "book")
        
        symbol
                  .resizable()
                  .scaledToFit()
                  .frame(width: size, height: size)
                  .font(Font.title.weight(.light))
                  .foregroundColor(.secondary.opacity(0.5))
      }
    }
  }
}

extension Image {
  init?(title: String) {
    guard
      let character = title.first,
      case let symbolName = "\(character.lowercased()).square",
      UIImage(systemName: symbolName) != nil
    else {
      return nil
    }
    self.init(systemName: symbolName)
  }
}

extension Book.Image {
  /// A preview image
  init(title: String) {
    self.init(image: nil, title: title, cornerRadius: .init())
  }
}

extension View {
  var previewedInAllColorSchemes: some View {
    ForEach(ColorScheme.allCases, id: \.self,
            content: preferredColorScheme)
  }
}

struct NewBookView: View {
  @ObservedObject var book = Book(title: "", author: "")
  @State var image: Image? = nil
  @EnvironmentObject var library: Library
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      VStack(spacing: 10) {
        TextField("Title", text: $book.title)
        TextField("Author", text: $book.author)
        ReviewAndImageView(book: book, image: $image)
      }
      .padding()
      .navigationBarTitle("Got a new book?")
      .toolbar() {
        ToolbarItem(placement: .status) {
          Button("Add to Library") {
            library.addNewBook(book, image: image)
            dismiss()
          }
        .disabled([book.title, book.author].contains(where: \.isEmpty))
        }
      }
    }
  }
}

struct Book_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
//      Book.Image(title: "")
//      Book.Image(title: "😻")
//      Book.Image(title: Book().title)
      NewBookView().environmentObject(Library())
    }
    .previewedInAllColorSchemes
  }
}
