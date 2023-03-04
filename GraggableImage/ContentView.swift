//
//  ContentView.swift
//  GraggableImage
//
//  Created by m1 on 04/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State var images: [[ImageModel]] = [
        [.init(name: "person", color: .red),
         .init(name: "xmark", color: .blue),
         .init(name: "circle.fill", color: .green)
        ],
        [.init(name: "circle.fill", color: .red),
         .init(name: "square.fill", color: .blue),
         .init(name: "bolt.fill", color: .green)
        ],
        [.init(name: "menucard.fill", color: .red),
         .init(name: "figure.walk", color: .blue),
         .init(name: "person", color: .green)
        ]
    ]
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.5).ignoresSafeArea()
            VStack {
                Text("Graggable Images").font(.largeTitle).fontWeight(.semibold).foregroundColor(.white).zIndex(10)
                Spacer()
                
                Grid {
                    ForEach(0..<images.count, id: \.self) { i in
                        GridRow {
                            ForEach(0..<images[i].count, id: \.self) { j in
                                ImageView(image: $images[i][j])
                            }
                        }
                    }
                }
                
                Spacer()
                Button(action: {
                    withAnimation {
                        // shuffle row
                        images = images.shuffled()
                        // shuffle within row
                        for i in 0..<images.count {
                            images[i] = images[i].shuffled()
                        }
                    }
                }, label: {
                    Text("Shuffle").foregroundColor(.cyan)
                        .fontWeight(.semibold).padding().frame(maxWidth: .infinity).background(
                            RoundedRectangle(cornerRadius: 10).fill(.black.opacity(0.9)).shadow(radius: 5)
                    )
                })
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
