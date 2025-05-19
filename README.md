# Weather App

A modern Flutter weather application that provides current weather information and 4-day forecast data based on the user's location. The app demonstrates clean architecture principles, comprehensive testing, and a polished user interface.

## Features

- Current weather information:
  - Temperature in Celsius
  - Location name
  - Current weather condition
- 4-day weather forecast:
  - Average daily temperature
  - Weather condition icons
- Location-based weather data
- Smooth animations and transitions
- Error handling and offline support
- Clean and intuitive user interface

## Technical Specifications

### Platform Support
- iOS: Version 12 and above
- Android: SDK version 24 (Android 7.0) and above

### Architecture
The project follows Clean Architecture principles with the following layers:
- **Presentation**: UI components, state management (Cubit)
- **Domain**: Business logic and entities
- **Data**: Repository implementation and data sources
- **Core**: Shared utilities and configurations

### Key Technologies and Libraries
- **State Management**: Flutter Bloc/Cubit
- **Dependency Injection**: get_it
- **Network**: Dio for API calls
- **Location Services**: geolocator
- **Testing**: flutter_test, bloc_test, mockito
- **Code Quality**: flutter_lints

## Project Structure
```
lib/
├── app/
├── core/
│   ├── config/
│   ├── network/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── screens/
    ├── widgets/
    └── controllers/
```

## Getting Started

### Prerequisites
- Flutter SDK (3.27.4)
- Xcode (for iOS development)
- Android Studio (for Android development)
- OpenWeather API key

### Setup
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Create a `.env` file in the project root and add your OpenWeather API key:
   ```
   API_KEY=<YOUR-API-KEY>
   BASE_URL=https://pro.openweathermap.org/data/2.5

   ```
4. Run the app:
   ```bash
   flutter run
   ```

### Running Tests
To run tests with coverage:
```bash
./coverage.sh
```

The project maintains a minimum of 80% test coverage across all layers.

## Architecture Decisions

### Clean Architecture
The project uses Clean Architecture to ensure:
- Separation of concerns
- Testability
- Maintainability
- Scalability

### State Management
Bloc/Cubit was chosen for state management because:
- Predictable state changes
- Built-in testing support
- Separation of business logic from UI
- Excellent documentation and community support

### Testing Strategy
The project implements:
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for key user flows
- Mocked dependencies for reliable testing
