//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Asya  on 21.11.2022.
//

import Foundation

protocol MoviesLoading {
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
    // MARK: - NetworkClient
    private let networkClient = NetworkClient()
    
    // MARK: - URL
    private var mostPopularMoviesUrl: URL {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_xck6jhcj") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
            
        }
        return url
    }
    private enum DecodingError: Error {
        case errorInCode
    }
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let data):
                let movieList = try? JSONDecoder().decode(MostPopularMovies.self, from: data)
                if let movieList = movieList {
                    handler(.success(movieList)) } else {
                        handler(.failure(DecodingError.errorInCode))
                        
                    }
            }
            
        }
        
    }
    
}


