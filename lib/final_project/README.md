# EDEM Furniture – Mobile Shopping Application

## Project Overview

EDEM Furniture is a mobile shopping application developed using Flutter and Dart.

The application helps users easily find furniture, explore different categories, view product information, and save their favorite items.

This project was created for the Final Capstone Project – Milestone 1.

## Problem and Target Users

**Problem:** Finding suitable furniture can be difficult when users need to compare different products and styles.

**Target Users:** People who want to buy furniture for their homes and prefer a simple mobile shopping experience.

**Solution:** EDEM Furniture provides an easy-to-use interface for browsing furniture, searching for products, and viewing detailed information.

## Main Features

- Home Screen with furniture products
- Furniture categories and search
- Product Detail Screen with images, prices, and descriptions
- Add to Favorites
- Add to Cart
- Bottom Navigation Bar
- Responsive mobile interface

## Screens

**Home Screen**
- Displays furniture products
- Includes search and category filters
- Uses product cards

**Product Detail Screen**
- Displays product image and information
- Shows rating, price, description, and tags
- Includes Favorite and Add to Cart buttons

**Favorites Screen**
- Displays products selected by the user

**Cart Screen**
- Displays added products and total price

**Profile Screen**
- Reserved for future development

## Technologies Used

- Flutter
- Dart
- Material Design

## Flutter Widgets Used

- StatelessWidget
- StatefulWidget
- setState()
- Scaffold
- Column and Row
- Stack
- Card
- GridView
- ListView
- Wrap
- Expanded

## Project Structure

```text
lib/
└── final_project/
    ├── main.dart
    ├── screens/
    │   ├── home_screen.dart
    │   └── product_detail_screen.dart
    ├── widgets/
    │   └── product_card.dart
    └── README.md

assets/
└── images/
    └── rixos.png
```

## How to Run

1. Install Flutter and Dart.
2. Open the project in VS Code or Android Studio.
3. Run `flutter pub get` in the project root.
4. Start an Android emulator or connect a phone.
5. Run the application:

```bash
flutter run -t lib/final_project/main.dart
```

For testing in Chrome:

```bash
flutter run -d chrome -t lib/final_project/main.dart
```

## Interactive Features

The application uses `StatefulWidget` and `setState()` to update the interface when users:

- Select furniture categories
- Add or remove favorite products
- Add products to the shopping cart
- Switch between navigation tabs

## Future Improvements

- User registration and login
- More furniture products and images
- Persistent favorites and cart
- Order history
- Online payment integration

## Project Status

**Milestone 1 – MVP UI Development**

The main discovery screen, product detail screen, and interactive features have been implemented. Additional device testing and UI improvements are planned.