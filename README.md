# SwiftUI Character Browser

Small iOS practice project built with **Swift** and **SwiftUI** to consume the Jikan API and display manga/anime character data in a native declarative interface.

This repository is part of a pair of learning projects that implement similar functionality twice: once with **UIKit** and once with **SwiftUI**. The goal was to compare both native iOS approaches and understand how the same app flow changes between imperative and declarative UI.

> Context: this was an open-ended training project created during my internship period at Worldline, after completing iOS learning paths. The idea, functionality, and code published here represent my own learning work and do not include proprietary company code, credentials, internal data, or confidential material.

## What it does

- Loads character data from the public **Jikan API**.
- Displays characters in a SwiftUI `List`.
- Uses `NavigationStack` and `NavigationLink` for list-to-detail navigation.
- Shows character images, names, roles, nicknames and description details.
- Uses `ObservableObject`, `@Published`, `@ObservedObject` and `@State` for simple state handling.

## Tech stack

| Area | Technology |
|---|---|
| Language | Swift |
| UI framework | SwiftUI |
| State management | `ObservableObject`, `@Published`, `@ObservedObject`, `@State` |
| Networking | `URLSession` |
| Data source | Jikan API |
| IDE | Xcode |

## Project structure

```text
swiftui_app/
├── Models/
│   ├── Character.swift
│   └── CharacterStore.swift
├── Views/
│   ├── ContentView.swift
│   ├── CharacterCellView.swift
│   └── CharacterDetailView.swift
└── swiftui_appApp.swift
```

## What this project demonstrates

- Native iOS development with SwiftUI.
- Declarative UI composition with reusable views.
- Navigation with `NavigationStack`.
- Basic reactive state updates through `ObservableObject`.
- Consuming REST API data from Swift.
- Mapping API responses into app models.
- Loading remote images and displaying detail information.

## Related project

The same idea was also implemented with UIKit in a separate repository:

- `AppUIKit` — UIKit version of this character browser.

## Status

Learning / portfolio project. It is not a production app, but it shows hands-on experience with native iOS fundamentals and the transition from UIKit to SwiftUI.

> Note: I currently do not have access to a Mac environment, so the README documents the project structure and intent, but recent local execution has not been verified.
