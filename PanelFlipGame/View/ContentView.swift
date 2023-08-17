//
//  ContentView.swift
//  PanelFlipGame
//
//  Created by 유하은 on 2023/08/17.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct ContentView: View {
    @State var isshowingSheet: Bool = true
    //여기다 바로 그릴 수는 없나?
    @State var tiles = Array(repeating: false, count: 25)
    @ObservedObject var tilesArray = GameStore()
    
    let layout: [GridItem] = [
        (GridItem(.flexible())),
        (GridItem(.flexible())),
        (GridItem(.flexible())),
        (GridItem(.flexible())),
        (GridItem(.flexible()))
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text("TILE FLIP")
                    .bold()
                    .font(.system(size: 36, design: .rounded))
                Image(systemName: "rectangle.fill")
                    .font(.system(size: 30))
            }

            LazyVGrid(columns: layout) {
                ForEach(tilesArray.tilesInGame.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .foregroundColor(tilesArray.tilesInGame[index].tileValue ? Color(uiColor: .black) : Color(uiColor: .cyan))
                        .onTapGesture {
                            tilesArray.changeData(index: index)
                        }
                }
                
            }.padding(10)
            
        }.task {
            tilesArray.setData()
            tilesArray.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
