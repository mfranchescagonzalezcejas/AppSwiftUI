# SwiftUI Character Browser

<div align="center">

<img src="https://img.shields.io/badge/Swift-SwiftUI-0F6B8F?style=flat-square" alt="Built with Swift and SwiftUI">
<img src="https://img.shields.io/badge/iOS-16.4%2B-0B8A8F?style=flat-square" alt="iOS 16.4 or later">
<img src="https://img.shields.io/badge/Project-learning%20portfolio-166F8C?style=flat-square" alt="Learning portfolio project">

Small iOS learning project that explores a SwiftUI character browser backed by the public [Jikan API](https://jikan.moe/).

</div>

---

This repository is part of a paired learning exercise: the same idea was also explored with UIKit to compare imperative and declarative native iOS UI.

> Context: this was an open-ended training project created during my internship period at Worldline, after completing iOS learning paths. The idea, functionality, and code published here represent my own learning work and do not include proprietary company code, credentials, internal data, or confidential material.

## Run Locally

**Requirements**

- macOS with Xcode 14.3 or later.
- An iOS 16.4+ simulator or connected iOS device supported by the installed Xcode version.
- Internet access to reach the Jikan API.

**Steps**

1. Open `swiftui_app.xcodeproj` in Xcode.
2. Select the `swiftui_app` scheme and an iOS 16.4+ simulator or device.
3. Run the app from Xcode.

The project file declares no Swift Package Manager dependencies, so no package installation step is documented.

> Note: I currently do not have access to a Mac environment, so the README documents the project structure and intent, but recent local execution has not been verified.

---

## Architecture & Decisions

The app is organized by responsibility rather than by screen:

```text
swiftui_app/
├── ui/          SwiftUI views, view models, and view state
├── domain/      Character model and repository contract
└── data/        Jikan network source, transport model, mapper, and repository implementation
```

| Decision | Rationale in this project |
| --- | --- |
| SwiftUI views own view models with `@StateObject` | Keeps list and detail state with their respective screens. |
| Repository contract separates UI from data access | View models request domain `Character` values instead of calling the network source directly. |
| `CharacterVO` maps to `Character` | Keeps the API-facing representation in the data layer. |
| `URLSession` and Foundation JSON parsing | Uses Apple frameworks already available to the app target. |

The runtime path is: `SwiftUI View -> ViewModel -> Repository -> LocalImpl -> NetworkImpl -> Jikan API`. `LocalImpl` currently delegates to the network implementation; it is not a persisted local store.

---

## Learning Focus

- SwiftUI screen composition and navigation.
- `ObservableObject` / `@Published` state updates.
- Async data loading with `URLSession`.
- Separating UI, domain, and data responsibilities.
