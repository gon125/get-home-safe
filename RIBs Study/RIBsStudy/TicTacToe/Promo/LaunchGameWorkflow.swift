//
//  LaunchGameWorkflow.swift
//  TicTacToe
//
//  Created by Geonhyeong LIm on 2021/04/14.
//  Copyright © 2021 Uber. All rights reserved.
//

import RIBs
import RxSwift

public class LaunchGameWorkflow: Workflow<RootActionableItem> {
    public init(url: URL) {
        super.init()
        
        let gameId = parseGameId(from: url)
        
        self
            .onStep { rootItem -> Observable<(LoggedInActionableItem, ())> in
                rootItem.waitForLogin()
            }
            .onStep { (loggedInItem, _) -> Observable<(LoggedInActionableItem, ())> in
                loggedInItem.launchGame(with: gameId)
            }
            .commit()
        
    }
    
    private func parseGameId(from url: URL) -> String? {
        let components = URLComponents(string: url.absoluteString)
        let items = components?.queryItems ?? []
        for item in items {
            where item.name == "gameId" {
                return item.value
            }
        }
        
        return nil
    }
}
