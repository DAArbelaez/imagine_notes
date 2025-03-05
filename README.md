# Imagine Notes

Imagine Notes is a cross-platform note-taking application built with Flutter, supporting Android and Web. The app enables users to create, edit, categorize, and search notes efficiently while synchronizing in real-time with Firebase.

## Features

- **Authentication:** Secure login and user authentication via Firebase Authentication.
- **Categorized Notes:** Organize notes into different categories with real-time updates.
- **CRUD Operations:** Create, edit, and delete notes with ease.
- **Search & Filtering:** Search notes while keeping category filtering active.
- **Real-Time Sync:** Notes are stored and updated in Cloud Firestore instantly.
- **State Management:** Uses BLoC for structured state handling.
- **Unit Testing:** Includes unit tests using Mockito and Flutter Test.

## Setup

### 1. Add Firebase Configuration
To properly use Firebase services, you must add the required configuration file:

- **For Android:** Place the `google-services.json` file inside `android/app/`.

### 2. Configure Environment Variables
The project requires environment variables stored in a `env` file at the root of the project.

Example `env` file:
```
WEBAPIKEY=your-web-api-key
WEBAPPID=your-web-app-id
AUTHDOMAIN=your-auth-domain
MEASUREMENTID=your-measurement-id

ANDROIDAPIKEY=your-android-api-key
ANDROIDAPPID=your-android-app-id

PROJECTID=your-project-id
MESSAGINGSENDERID=your-messaging-sender-id
STORAGEBUCKET=your-storage-bucket
```

### 3. Install Dependencies
Run the following command to install required dependencies:
```bash
flutter pub get
```

### 4. Run the Application
```bash
flutter run
```

## Running Tests
To execute unit tests:
```bash
flutter test
```
