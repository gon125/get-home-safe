//
//  LoggedInActionableItem.swift
//  TicTacToe
//
//  Created by Geonhyeong LIm on 2021/04/14.
//  Copyright © 2021 Uber. All rights reserved.
//

import RxSwift

public protocol LoggedInActionableItem: class {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())>
}
