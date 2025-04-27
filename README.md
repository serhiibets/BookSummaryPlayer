# Book Summary Player

[![Generic badge](https://img.shields.io/badge/BookPlayer-v.1.0.0-brightgreen.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/OS-iOS-brightgreen.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/Language-Swift-orange)](https://shields.io/)

# What is BookPlayer?
**BookPlayer** is a clean and professional audiobook player app, allowing users to listen to chapters, control playback speed, set sleep timers, and enjoy a smooth listening experience through a beautiful and minimalistic UI.

It’s built with **Swift**, using **AudioKit** for seamless audio playback, **Composable Architecture (TCA)** for scalable state management, and fully covered by **unit tests** for maximum reliability.

---

## Screenshots of the app
[<img src=https://github.com/serhiibets/BookSummaryPlayer/blob/main/documentation/screenshots/app_image.png height=400>]

---

# Features
- Play audiobooks with full control: play, pause, seek, fast-forward, rewind.
- Dynamic playback speed adjustment (0.5x to 2.0x).
- Sleep timer support (auto-pause after selected time).
- Chapter navigation: easily jump between chapters.
- Real-time playback tracking with smooth UI updates.
- Error handling and user-friendly alerts.
- Built with a fully testable architecture (TCA) and dependency injection.

---

# Clean Architecture & Patterns
### Patterns Used:
- **TCA (The Composable Architecture)** — fully modular and scalable.
- **MVVM** separation for reusable components.
- **Dependency Injection** — via `@Dependency` property wrappers.
- **SOLID principles** — clean, extendable, maintainable code.

### Technologies:
- **AudioKit** — professional audio playback.
- **Swift Concurrency** (async/await) — modern concurrency.
- **SwiftUI** — full native UI without storyboards.
- **Unit Testing** — maximum test coverage with `XCTest` and `TestStore`.

### Package Managers:
- **Swift Package Manager** (SPM) — no CocoaPods or Carthage.

---

# Project Highlights
- 100% Swift codebase.
- Code-first UI (no storyboards, no xibs).
- Custom mocks for audio services for reliable unit tests.
- Professional coverage strategy.
- Clean project structure ready for production scaling.

---

# License
