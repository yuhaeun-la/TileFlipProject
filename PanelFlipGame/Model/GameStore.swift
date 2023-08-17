//
//  GameStore.swift
//  PanelFlipGame
//
//  Created by 유하은 on 2023/08/17.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class GameStore: ObservableObject {
    @Published var tilesInGame : [tileFlip] = []
    
    //    var teamYellowCount: Int {
    //        tiles.panelValue.filter{!($0)}.count
    //    }
    //    var teamPurpleCount: Int {
    //        tiles.panelValue.filter{($0)}.count
    //    }
    //
    
    init() {
        self.tilesInGame = (0..<25).map { _ in arc4random_uniform(2) == 0 ? tileFlip(tileValue: true) : tileFlip(tileValue: false) }
        
        setData()
    }
    
    func setData() {
        for index in tilesInGame.indices {
            Firestore.firestore().collection("Tiles")
                .document(tilesInGame[index].id)
                .setData(["tileValue": tilesInGame[index]])
        }
    }
    
    //    func setData2() {
    //        Firestore.firestore().collection("Tiles").getDocuments { snapshot, error in
    //            if let snapshot {
    //                let docData = snapshot.documents[0].data()
    //                var tilesArray = docData["tiles"]
    //
    //                for index in self.tilesInGame.indices {
    //                    Firestore.firestore().collection("Tiles")
    //                        .document("APm3BwKLyRi9FUE93mQt")
    //                        .setData(["tilesArray\([index])": self.tilesInGame[index]])
    //                }
    //            }
    //        }
    //    }
    //let tilesArray = data["tiles"]
    // [tiles:[true,false,true]]
    //1번째 가져오지?
    // tile.values.first()
    
    
    
    func changeData(index: Int) { //(index:index로 써야함 )
        tilesInGame[index].tileValue.toggle()
        
        
        Firestore.firestore().collection("Tiles")
            .document(tilesInGame[index].id)
            .setData(["tileValue": tilesInGame[index]])
        
    }
    
    func fetchData() { //snapshot이라는 개념이,,뭐지?
        Firestore.firestore().collection("Tile").getDocuments { (snapshot, error) in
            if let snapshot {
                var savedTileArray: [tileFlip] = []
                
                for document in snapshot.documents {
                    let id: String = document.documentID
                    
                    let docData = document.data()
                    let tileValue: Bool = docData["tileValue"] as? Bool ?? true
                    
                    let memo: tileFlip = tileFlip(id: id, tileValue: tileValue)
                    savedTileArray.append(memo)
                }
                
                self.tilesInGame = savedTileArray
                
            }
        }
    }
    
    
    
    
    
}
