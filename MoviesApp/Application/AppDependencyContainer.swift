//
//  AppDependencyContainer.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import Foundation

class AppDependencyContainer {
    var homeDependencyContainer: HomeDependencyContainer {
        DefaultHomeDependencyContainer()
    }
}
