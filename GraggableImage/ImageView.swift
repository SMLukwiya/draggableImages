//
//  ImageView.swift
//  GraggableImage
//
//  Created by m1 on 04/03/2023.
//

import SwiftUI

struct ImageView: View {
    @Binding var image: ImageModel
    @State var dragAmount = CGSize.zero
    @State var tapped: Bool = false
    let returnDuration  : Double =  0.3
    
    var isDragging  : Bool {
        dragAmount != .zero
    }
    
    var drag: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                withAnimation {
                    // update drag with current drag offset
                    dragAmount = CGSize(width: value.translation.width, height: value.translation.height)
                    // update zindex
                    image = ImageModel(name: image.name, color: image.color, zIndex: 1.0)
                }
            }
            .onEnded { _ in
                withAnimation {
                    // return to original drag postion
                    dragAmount = .zero
                    
                    // add some delay when animating back
                    DispatchQueue.main.asyncAfter(deadline: .now() + returnDuration) {
                        // change image back using name, color init
                        image = ImageModel(name: image.name, color: image.color )
                    }
                    
                }
            }
    }
    var body: some View {
        Image(systemName: image.name)
            .imageScale(.large)
            .foregroundColor(image.color)
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(
                        LinearGradient(colors: [.black, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    if dragAmount != .zero {
                        RoundedRectangle(cornerRadius: 10).stroke(image.color, lineWidth: 2).blur(radius: 3 )
                    }
                }
            )
            .opacity(isDragging ? 0.9 : 1.0)
            .zIndex(image.zIndex)
            .scaleEffect(isDragging ? 1.2 : 1.0)
            .offset(dragAmount)
            .scaleEffect(tapped ? 1.1 : 1.0 )
            .animation(.spring(response: 0.4, dampingFraction: 0.5), value: tapped)
            .gesture(drag)
            .onTapGesture {
                tapped = true
                image = ImageModel(name: image.name)
                DispatchQueue.main.asyncAfter(deadline: .now() + returnDuration) {
                   tapped = false
                }
            }
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack {
                Text("Some Text").foregroundColor(.white).font(.largeTitle).fontWeight(.bold)
                Spacer()
                ImageView(  image: .constant(.init(name: "menucard.fill", color: .red)))
                Spacer()
            }
        }
    }
}
