# CCON

CCON is a real-time currency converter that allows users to convert between various currencies. It supports multiple target currencies, lets users add and delete preferred target currencies, and saves preferences locally.

## Architecture

The app follows the BLoC (Business Logic Component) design pattern with Cubits for state management. This approach separates the business logic from the UI, making the codebase more maintainable and testable. The BLoC pattern helps manage the state efficiently by providing a clear flow of data between the UI and business logic layers. Instead of the event-state-bloc pattern, **Cubits** were used to manage states efficiently using BLoC pattern.

![Slide 16_9 - 1 (1)](https://github.com/user-attachments/assets/41f1ca6a-48e0-42c0-9dd1-c3aa865c009f)

## Features

1. **Real-Time Currency Converter**: Convert currencies using up-to-date exchange rates.
2. **Multiple Currency Conversions**: Add and convert to several target currencies simultaneously.
3. **Local Currency Preferences**: Save and retrieve preferred target currencies locally.
4. **Manage Preferred Currencies**: Add or delete preferred target currencies as needed.

## Setup Instructions

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/kodiidok/ccon.git
   cd ccon
   ```

2. **Install Dependencies**:
   Ensure you have Flutter installed. Then, run:
   ```sh
   flutter pub get
   ```

3. **Run the App**:
   Connect your device or start an emulator, and run:
   ```sh
   flutter run
   ```

## Libraries Used

- **`cupertino_icons: ^1.0.6`**: Provides iOS-style icons for the app.
- **`flutter_bloc: ^8.1.6`**: Manages state using BLoC and Cubits, facilitating clear separation of business logic and UI.
- **`http: ^1.2.2`**: Handles HTTP requests to fetch real-time currency data.
- **`shared_preferences: ^2.3.2`**: Manages local data persistence for storing user preferences.
- **`equatable: ^2.0.5`**: Simplifies value comparison in Cubits and BLoCs.
- **`provider: ^6.1.2`**: Assists with dependency injection and state management, complementing BLoC.

## Design

The app follows a user-friendly design, adhering to the given instructions and sample layout design. The UI is crafted to be intuitive and easy to navigate, ensuring a smooth user experience.

## API Documentation

For detailed information on the currency API and the latest exchange rates, refer to [Frankfurter API Documentation](https://www.frankfurter.app/docs).
