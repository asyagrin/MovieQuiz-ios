//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Asya  on 14.11.2022.
//

import Foundation

protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
    func store(correct count: Int, total amount: Int)
}

