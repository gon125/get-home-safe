//
//  ScoreStream.swift
//  TicTacToe
//
//  Created by Geonhyeong LIm on 2021/04/13.
//  Copyright © 2021 Uber. All rights reserved.
//

import RxSwift

struct Score: Equatable {
    let player1Score: Int
    let player2Score: Int
}

protocol ScoreStream: class {
    var score: Observable<Score> { get }
}

protocol MutableScoreStream: ScoreStream {
    func updateScore(withWinner winner: PlayerType?)
}

class ScoreStreamImpl: MutableScoreStream {
    func updateScore(withWinner winner: PlayerType?) {
        let newScore: Score = {
            let currentScore = variable.value
            switch winner {
            case .player1:
                return Score(player1Score: currentScore.player1Score + 1, player2Score: currentScore.player2Score)
            case .player2:
                return Score(player1Score: currentScore.player1Score, player2Score: currentScore.player2Score + 1)
            case .none:
                return Score(player1Score: currentScore.player1Score + 1, player2Score: currentScore.player2Score + 1)
            }
        }()
        variable.value = newScore
    }
    
    var score: Observable<Score> { variable.asObservable().distinctUntilChanged { $0 == $1 } }
    
    // MARK: - Private
    private let variable = Variable<Score>(Score(player1Score: 0, player2Score: 0))
}
