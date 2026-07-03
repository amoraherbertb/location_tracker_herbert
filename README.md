# 📍 Location Tracker App (Flutter Clean Architecture + BLoC)

A Flutter-based location tracking application built with Clean Architecture and BLoC, demonstrating real-time GPS tracking, Haversine distance calculation, and local persistence using Hive.

The app records device location every 5 seconds, computes distance from a dynamic target fetched from a mock data source, and displays tracking history with filtering options.

This project is designed as a technical assessment to showcase scalable architecture, clean separation of concerns, and practical state management using `flutter_bloc` and dependency injection via `GetIt`.

---

## 🚀 Features

### 📡 Location Tracking
- Start and stop tracking
- Captures device location every 5 seconds (foreground only)

### 🎯 Target-Based Distance Calculation
- Fetches mock target location from local JSON
- Calculates distance using the Haversine formula

### 💾 Local Persistence
- Stores tracking records using Hive
- Saves:
  - Timestamp
  - Latitude
  - Longitude
  - Distance

### 📊 Tracking History
- Displays all recorded locations in a scrollable list
- Each item shows:
  - Timestamp
  - Coordinates
  - Distance from target

### 🔎 Filtering
- View most recent records:
  - 5
  - 10
  - 15
  - 20

---

## 🧱 Architecture

Feature-first Clean Architecture with strict separation of concerns

---

## ⚙️ Tech Stack

- Flutter
- Dart
- BLoC (`flutter_bloc`)
- GetIt (Dependency Injection)
- Hive (Local Storage)
- Geolocator (Location Services)

---

## 📦 Setup Instructions

### 1. Clone repository

```bash
git clone https://github.com/amoraherbertb/location_tracker_herbert.git
cd location-tracker-app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Generate Hive Adapters

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Add Android permissions
Edit:
```bash
android/app/src/main/AndroidManifest.xml
```
Add:
```bash
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### 5. Add iOS permissions
Edit:
```bash
ios/Runner/Info.plist
```
Add:
```bash
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app uses your location to track distance from a target point.</string>
```

### 6. Add mock target JSON

Create:
```bash
assets/mock/target.json
```
Example:
```bash
{
  "id": "001",
  "target_lat": 1.265,
  "target_lng": 103.695
}
```
### 7. Run the app
```bash
flutter run
```

## HOW IT WORKS
User starts tracking
   ↓
Permission check
   ↓
Fetch target coordinates
   ↓
Start 5-second timer
   ↓
Get device location
   ↓
Calculate distance (Haversine)
   ↓
Save to Hive
   ↓
Reload filtered records
   ↓
Update UI via BLoC
