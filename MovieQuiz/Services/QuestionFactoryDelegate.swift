//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Asya  on 08.11.2022.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
