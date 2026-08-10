# SwiftUI Character Browser

Small native iOS training project that explores a character browser built with SwiftUI and backed by the public [Jikan API](https://jikan.moe/).

This repository is part of a paired learning exercise: the same application concept was also implemented with UIKit to compare imperative and declarative approaches to native iOS UI development.

> **Context:** this project was created during my internship period at Worldline after completing internal iOS learning paths. The application idea, functionality, and code published here are my own training work and contain no proprietary company code, credentials, internal data, or confidential material.

---

## Run Locally

### Requirements

- macOS with Xcode 14.3 or later.
- An iOS 16.4+ simulator or compatible physical device.
- Internet access to reach the Jikan API.

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
└── data/        Jikan network source, transport model, mapper, and repository implementation
```

| Decision                                                | Rationale                                                                                      |
| ------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| SwiftUI views own their view models with `@StateObject` | Keeps screen-specific state alive across SwiftUI view updates.                                 |
| Repository contract separates UI from data access       | View models depend on domain `Character` values instead of directly accessing networking code. |
| `CharacterVO` maps to `Character`                       | Keeps API transport models isolated from the domain layer.                                     |
| `URLSession` and Foundation JSON parsing                | Uses native Apple frameworks without introducing external dependencies.                        |

The main data flow is:

```text
SwiftUI View
    ↓
ViewModel
    ↓
Repository
    ↓
Data implementation
    ↓
Jikan network source
    ↓
Jikan API
```

A `LocalImpl` type exists in the current structure, but it does not provide persisted local storage; it currently delegates data retrieval to the network implementation.

---

## Learning Focus

This project was mainly used to practice:

- SwiftUI screen composition.
- Declarative UI development.
- Navigation between list and detail screens.
- `ObservableObject` and `@Published` state management.
- View model ownership with `@StateObject`.
- Asynchronous data loading with `URLSession`.
- Mapping API transport models into domain models.
- Repository-based separation between UI, domain, and data layers.

---

## What I Would Improve Today

If I revisited the project today, I would consider:

- Migrating networking code to modern Swift concurrency with `async/await`.
- Making loading, success, and error states more explicit.
- Reviewing the repository abstraction to simplify layers that do not currently provide independent behavior.
- Adding unit tests for view models, mapping logic, and repository behavior.
- Improving dependency injection to make the data layer easier to test.
- Revisiting navigation and state management using current SwiftUI APIs.
