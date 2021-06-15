//
//  ContentView.swift
//  RealityPlus
//
//  Created by Martin Brian on 30/5/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var showingSheet = false
    
    @State var finishedCoaching: Bool = false
    @State var addBall: Bool = false
    @State var score: Int = 0
    
    
    // agragar camuflaje de la pelota, cambio de lado de la cámara, disminuir tamaño, etc
    //en lugar de botón, pelota para apretar que siempre esté enfrente, a un metro
    
    var body: some View {
        ZStack {
            ARViewContainer(finishedCoaching: $finishedCoaching, addBall: $addBall, score: $score)
            VStack() {
                if addBall {
                    Text(String(score))
                        .font(.system(size: 30))
                }
                Spacer()
                if finishedCoaching && !addBall {
                    Button {
                        addBall.toggle()
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .foregroundColor(Color.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 38, height: 38)
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                SheetView(text: "The game is on, find the ball and click on it.")
            }
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    var text: String = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                }
            }
            Text(text)
                .padding()
        }
    }
}
