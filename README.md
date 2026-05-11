# BookNest

BookNest is an offline SwiftUI reading tracker for managing a personal library, journal notes, reading goals, and reading statistics.

## Features

- Add, edit, search, filter, and delete books.
- Track reading status, format, genre, page progress, notes, and ratings.
- Save journal notes locally and optionally link them to saved books.
- Create reading goals for books finished, pages read, or minutes read.
- View dashboard highlights for the current book, recent books, and active goal progress.
- View reading statistics and a genre breakdown chart.

## Offline Storage

BookNest uses SwiftData for local device storage. The app does not require login, network access, CloudKit, or an account. Books, notes, goals, and progress are stored on the device and remain available after relaunch.

## Tech Stack

- SwiftUI
- SwiftData
- Swift Charts
- SF Symbols

## Portfolio Notes

The app is structured around small SwiftUI views, reusable components, local persistence, and clear model-driven state. Runtime screens use SwiftData queries instead of sample data so the app behaves like a real offline product.
