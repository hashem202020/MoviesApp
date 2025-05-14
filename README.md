# 🎬 Movie App

A lightweight iOS app built with Swift and UIKit (no RxSwift), supporting:

- 🔍 Movie search and browsing
- 📄 Movie details with cast and similar suggestions
- ⭐ Add/remove movies to/from a local watchlist
- 🧠 Clean Architecture
- 📦 Dependency injection without external libraries

---

## 🛠 Features

### 🔍 Movie List with Search
- Dynamically loads movies from the API
- Allows searching via a search bar
- Presents results in a responsive `UITableView`

### 📄 Movie Details Screen
- Displays full movie information
- Includes cast (directors & actors)
- Shows similar movies as a horizontal list

### ⭐ Watchlist Support
- Add/remove a movie to your watchlist from the detail screen
- Watchlist is stored locally using `UserDefaults`
- Keeps track of watchlist across sessions

---

## 📦 Tech Stack

- UIKit
- MVVM 
- Combine
- Swift Concurrency (`async/await`)
- UserDefaults for local storage
- Custom dependency injection
- Clean architecture

---

## 🧠 Architecture

### Clean Architecture

- This application is structured using Clean Architecture principles, which separates concerns into different layers, improving maintainability and testability. The key layers include:
    - Presentation Layer: Contains views and ViewModels. This layer is responsible for interacting with the user interface and receiving input.
    - Domain Layer: Contains the business logic and entities. This layer is independent of any frameworks or UI.
    - Data Layer: Manages data sources such as APIs, databases, and local storage. This layer handles data retrieval and storage.

### MVVM (Model-View-ViewModel)

The app uses the MVVM pattern to separate the UI from business logic:
- Model: Represents the data and its business logic.
- View: The views that display the data.
- ViewModel: Acts as an intermediary between the View and the Model, managing the data presentation logic and state.

---

## 🚀 Getting Started
1. Clone the repository:
git clone https://github.com/hashem202020/MoviesApp.git

2. Open in Xcode:
open MoviesApp.xcodeproj

3. Build & Run

---

## 📦 Future Improvements

 Persist watchlist on iCloud or backend
 Unit testing for use cases and view models
 SwiftUI version

---

## 🙌 Credits

This app uses The Movie Database (TMDb) API but is not endorsed or certified by TMDb.
