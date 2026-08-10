# SwiftUI Character Browser

Small native iOS training project that explores a character browser built with **SwiftUI** and backed by the public [Jikan API](https://jikan.moe/).

This repository is part of a paired learning exercise: the same application concept was also implemented with UIKit to compare imperative and declarative approaches to native iOS UI development.

> **Context:** this project was created during my internship period at Worldline after completing internal iOS learning paths. The application idea, functionality, and code published here are my own training work and contain no proprietary company code, credentials, internal data, or confidential material.

---

## Run Locally

### Requirements

* macOS with Xcode 14.3 or later.
* An iOS 16.4+ simulator or compatible physical device.
* Internet access to reach the Jikan API.

### Steps

1. Open `swiftui_app.xcodeproj` in Xcode.
2. Select the `swiftui_app` scheme.
3. Choose an iOS 16.4+ simulator or compatible device.
4. Run the application from Xcode.

The project does not declare any Swift Package Manager dependencies, so no additional package installation step is required.

> **Note:** I currently do not have access to a macOS development environment, so recent local execution has not been revalidated. The repository and README reflect the original project structure and implementation.

---

## Architecture & Decisions

The project is organized by responsibility rather than by screen:

```text
swiftui_app/
├── ui/          SwiftUI views, view models, and view state
├── domain/      Character model and repository contract
└── data/        Network source, transport model, mapper, and repository implementation
```

| Decision                                                                        | Rationale                                                                                      |
| ------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| SwiftUI views own their view models with `@StateObject`                         | Keeps screen-specific observable state alive across SwiftUI view updates.                      |
| View models conform to `ObservableObject` and expose state through `@Published` | Allows SwiftUI to react automatically when application state changes.                          |
| Repository contract separates UI from data access                               | View models depend on domain `Character` values instead of accessing networking code directly. |
| `CharacterVO` maps to `Character`                                               | Keeps API-facing transport models separate from domain models.                                 |
| `URLSession` with `async/await`                                                 | Uses Apple-native networking with Swift structured concurrency and no external dependencies.   |

The main data flow is:

```text
SwiftUI View
    ↓
ViewModel
    ↓
Repository
    ↓
LocalImpl
    ↓
NetworkImpl
    ↓
Jikan API
```

`LocalImpl` currently acts as a forwarding layer and does not provide persisted local storage; it delegates requests to the network implementation.

When data returns, the view model updates its published `BaseState`. SwiftUI observes those changes and recomputes the affected view hierarchy.

---

## UI & Navigation

The list screen uses:

* `NavigationStack`.
* `LazyVGrid` for a two-column character layout.
* `ForEach` to render character data.
* `NavigationLink` and `navigationDestination` to open the detail screen.
* `ProgressView` for loading state.
* `@StateObject` to own the list view model.

The detail screen owns its own `CharacterDetailViewModel`, loads additional character information, and renders the updated state declaratively.

---

## Learning Focus

This project was mainly used to practice:

* SwiftUI screen composition.
* Declarative UI development.
* `NavigationStack` and value-based navigation.
* `LazyVGrid` and `ForEach`.
* `ObservableObject` and `@Published` state management.
* View model ownership with `@StateObject`.
* Swift concurrency with `async/await`.
* Asynchronous networking with `URLSession`.
* Main-thread state updates.
* Mapping API transport models into domain models.
* Repository-based separation between UI, domain, and data layers.
* Loading list data and requesting additional information for a selected character.

---

## What I Would Improve Today

If I revisited the project today, I would consider:

* Replacing manual `JSONSerialization` and forced casts with `Codable`.
* Making loading, success, and error states explicit, preferably through a dedicated state model or enum.
* Simplifying the `LocalImpl` abstraction while it does not provide caching or persistent storage.
* Improving dependency injection instead of constructing concrete repository and data-source implementations internally.
* Adding cancellation support and clearer task ownership for asynchronous operations.
* Making main-actor boundaries more explicit for observable UI state.
* Adding unit tests for view models, mapping logic, repository behavior, and networking.
* Reducing force unwraps in the UI, particularly around optional character data.
* Reviewing mutable domain-model state and whether detail data should be represented with immutable values.
* Evaluating current SwiftUI observation and navigation APIs if the project were actively maintained.

---

## Related Project

The same application concept was also implemented with UIKit:

* `AppUIKit` — imperative UIKit version of this character browser.

---

## Status

Training / portfolio project originally created to practice native iOS development and compare UIKit with SwiftUI.

> **Note:** I currently do not have access to a macOS development environment, so recent local execution has not been revalidated. The repository and README reflect the original project structure and implementation.
