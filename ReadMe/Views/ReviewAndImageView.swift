//
//  ReviewAndImageView.swift
//  ReadMe
//
//  Created by Guilherme de Carvalho Correa on 25/04/23.
//

import class PhotosUI.PHPickerViewController
import SwiftUI

struct ReviewAndImageView: View {
  @ObservedObject var book: Book
  @Binding var image: Image?
  @State var showingImagePicker = false
  @State var showingDeleteImage = false
  
  var body: some View {
    VStack {
      Divider()
        .padding(.vertical)
      TextField("Review", text: $book.microReview)
      Divider()
        .padding(.vertical)
      Book.Image(image: image, title: book.title, cornerRadius: 16)
        .scaledToFit()
      HStack {
        if image != nil {
          Spacer()
          Button("Delete Image") {
            showingDeleteImage = true
          }
        }
        Spacer()
        Button("Update Image...") {
          showingImagePicker = true
        }
        Spacer()
      }
      .padding()
      Spacer()
    }
    .sheet(isPresented: $showingImagePicker) {
      PHPickerViewController.View(image: $image)
    }
    .confirmationDialog("Delete image for \(book.title)?",
                        isPresented: $showingDeleteImage) {
      Button("Delete", role: .destructive) {
        image = nil
      }
    } message: {
      Text("Delete image for \(book.title)?")
    }
  }
}

struct ReviewAndImageView_Previews: PreviewProvider {
    static var previews: some View {
      ReviewAndImageView(book: .init(), image: .constant(nil))
        .padding(.horizontal)
    }
}
