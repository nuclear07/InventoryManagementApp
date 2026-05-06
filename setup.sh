#!/bin/bash
# Complete Flutter Smart Inventory App Setup Script
# This script will create all necessary directories and files

# Create directory structure
mkdir -p lib/{models,core/{constants,theme,utils},data/repositories,providers,presentation/{routes,screens,widgets}}

# Create pubspec.yaml
cat > pubspec.yaml << 'PUBSPEC_EOF'
name: smart_inventory
description: "A complete, production-ready Smart Inventory & Stock Replenishment mobile application with offline support."
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management - Riverpod
  flutter_riverpod: ^2.4.8
  riverpod_annotation: ^2.3.0

  # Local Storage - Hive
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # Firebase (optional but recommended)
  firebase_core: ^2.24.0
  cloud_firestore: ^4.13.0
  firebase_auth: ^4.14.0

  # Routing
  go_router: ^13.0.0

  # UI & Material Design 3
  intl: ^0.19.0
  cached_network_image: ^3.3.0

  # Networking
  http: ^1.1.0

  # Utils
  uuid: ^4.0.0
  connectivity_plus: ^5.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^3.0.0

  # Code Generation for Riverpod
  riverpod_generator: ^2.3.7
  build_runner: ^2.4.6

  # Code Generation for Hive
  hive_generator: ^2.0.0

flutter:
  uses-material-design: true
PUBSPEC_EOF

echo "✅ Setup script created successfully!"
echo "📋 Run this script to create the complete project structure"
echo "🚀 Then use 'flutter pub get' and 'flutter pub run build_runner build'"
