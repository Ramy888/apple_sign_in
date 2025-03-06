# Flutter Apple Sign-In with Firebase

A Flutter application that demonstrates how to implement Apple Sign-In using Firebase Authentication. This app provides a secure and seamless sign-in experience for iOS users.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [1. Firebase Setup](#1-firebase-setup)
  - [2. Apple Developer Account Setup](#2-apple-developer-account-setup)
  - [3. Xcode Configuration](#3-xcode-configuration)
  - [4. Flutter Project Setup](#4-flutter-project-setup)
- [Running the App](#running-the-app)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before you begin, ensure you have:
- [Flutter](https://flutter.dev/docs/get-started/install) installed (3.0.0 or higher)
- [Xcode](https://developer.apple.com/xcode/) installed (latest version recommended)
- An [Apple Developer Account](https://developer.apple.com/) (paid membership required)
- A [Firebase account](https://firebase.google.com/)
- [CocoaPods](https://cocoapods.org/) installed

## Setup Instructions

### 1. Firebase Setup

1. Create a new Firebase project:
   - Go to the [Firebase Console](https://console.firebase.google.com/)
   - Click "Add Project"
   - Enter your project name and follow the setup wizard

2. Add iOS app to Firebase:
   ```bash
   # Your iOS bundle ID should match this format
   com.yourdomain.appname
   ```

3. Download `GoogleService-Info.plist`:
   - After registering your iOS app, download the `GoogleService-Info.plist` file
   - Place it in your Flutter project at: `ios/Runner/GoogleService-Info.plist`

4. Enable Apple Sign-In in Firebase:
   - In Firebase Console, go to Authentication
   - Click "Sign-in method"
   - Enable "Apple" as a sign-in provider

### 2. Apple Developer Account Setup

1. Create App ID:
   - Go to [Apple Developer Portal](https://developer.apple.com/account/resources/identifiers/list)
   - Click "+" to register new identifier
   - Select "App IDs"
   - Choose "App" as the type
   - Enter description and Bundle ID (same as used in Firebase)
   - Enable "Sign In with Apple" capability
   - Register the App ID

2. Create Service ID:
   - In Identifiers section, click "+"
   - Select "Services IDs"
   - Enter description and identifier (e.g., com.yourdomain.appname.signin)
   - After creating, click on the Service ID
   - Enable "Sign In with Apple"
   - Configure primary app ID
   - Add domains and return URLs:
   ```
   Domain: appname.firebaseapp.com
   Return URL: https://appname.firebaseapp.com/__/auth/handler
   ```

3. Generate Private Key:
   - Go to "Keys" section
   - Click "+" to add new key
   - Enable "Sign In with Apple"
   - Download the key file (.p8)
   - Note down the Key ID

4. Note Important Information:
   - Team ID (found in top right of Apple Developer account)
   - Bundle ID
   - Service ID
   - Key ID
   - Private Key file (.p8)

### 3. Xcode Configuration

1. Open your Flutter project in Xcode:
   ```bash
   cd ios
   open Runner.xcworkspace
   ```

2. Configure Signing & Capabilities:
   - Select Runner project
   - Select Runner target
   - Go to "Signing & Capabilities"
   - Sign in with your Apple Developer account
   - Select your team
   - Add capability:
     - Click "+" and add "Sign In with Apple"

3. Update Bundle Identifier:
   - Ensure it matches your Firebase and Apple Developer setup

### 4. Flutter Project Setup

1. Add dependencies to `pubspec.yaml`:
   ```yaml
   dependencies:
     firebase_core: ^2.24.2
     firebase_auth: ^4.15.3
     sign_in_with_apple: ^5.0.0
     crypto: ^3.0.3
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Update iOS deployment target:
   - Open `ios/Podfile`
   - Set platform version to 13.0 or higher:
   ```ruby
   platform :ios, '13.0'
   ```

4. Install pods:
   ```bash
   cd ios
   pod install
   cd ..
   ```

## Running the App

1. Ensure all configuration files are in place:
   - `GoogleService-Info.plist` in `ios/Runner`
   - Updated `Info.plist` with required permissions
   - Firebase configuration in your project

2. Run the app:
   ```bash
   flutter run
   ```

## Troubleshooting

Common issues and solutions:

1. "Sign In with Apple" button not showing:
   - Verify Apple Developer account is active
   - Check if Sign In with Apple capability is enabled in Xcode
   - Ensure minimum iOS version is 13.0 or higher

2. Firebase authentication failed:
   - Verify `GoogleService-Info.plist` is correctly placed
   - Check if Apple Sign In is enabled in Firebase Console
   - Verify all Apple Developer configurations match

3. Build errors:
   - Run `flutter clean`
   - Delete `ios/Pods` folder
   - Run `pod install` in ios directory
   - Try building again

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by Ramy888

## Last Updated

2025-03-06
