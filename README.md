# Flutter Stations Map App

[![Maintanence](https://img.shields.io/badge/Maintenance-yes%3F-blue.svg)]()
[![Codemagic build status](https://api.codemagic.io/apps/63905b4f2551810eda63638f/63905b4f2551810eda63638e/status_badge.svg)](https://codemagic.io/apps/63905b4f2551810eda63638f/63905b4f2551810eda63638e/latest_build)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)]()
![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)
![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)
![Supported Platforms](https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web%20%20-blue.svg?logo=flutter)
[![View DEMO](https://img.shields.io/badge/VIEW-DEMO-lightgreen.svg)](https://animated-alfajores-40eb7b.netlify.app)

## Project info 
- This project is a app that shows a map with Electric Charging Stations and their information. The app supports station markers clustering.
- The app runs on Android, iOS and Web.
- The app is built using Flutter 3.3 and Dart.
- The app is built using the MVVM architecture.
- The app is built using the BLoC pattern.

## Demo
[Stations Map App](https://animated-alfajores-40eb7b.netlify.app)

https://user-images.githubusercontent.com/42183561/220624033-6834b985-5027-4b1c-b5b0-f18ffe84f5f8.mp4


## How to run the app
- **Clone the project.**
```shell
git clone https://github.com/extrawest/evc_google_maps_demo.git
```
- **Open the project.**
```shell
cd your_name_here
```
- **Get packages.**
```shell
flutter pub get
```
- **Configure firebase project with flutterfire.**
```shell
flutterfire configure
```
- **Run the app with your api key for the map as additional run argument.**
```
    flutter run --dart-define MAP_API_KEY="{YOUR_API_KEY_HERE}"
```

At this point you should be able to run the app on your device or emulator.

## Firebase hosting

1. In order to deploy this app to Firebase hosting, follow these commands

- **Login to firebase.**
```shell
firebase login
```
- **Initialize firebase.**
```shell
firebase init
```
- **Choose account, then choose Hosting as an option.**
- **Select Firebase project**
- **Select public directory for your hosting**
build/web (default)
- **Configure as a single-page app**
- **Build the project if you haven't yet**
```shell
flutter build web
```
- **Deploy to firebase.**
```shell
firebase deploy
```


Created by **Oleksii Melnychenko**

[Extrawest.com](https://www.extrawest.com), 2022


