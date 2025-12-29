# SocietyEase - Smart Housing Ecosystem 🏙️✨

SocietyEase is a sophisticated, feature-rich housing society management platform designed to bridge the gap between residents and management committees using cutting-edge design and seamless digital workflows. It features a state-of-the-art **Bento Grid UI**, real-time updates, and a robust role-based access system.

---

## 🌟 Project Highlights

### 🎨 Design Philosophy
- **Modern Aesthetics**: Built with a proprietary **Bento Grid** system, featuring pastel gradients, authentic glassmorphism, and consistent spacing.
- **Fluid Experience**: Immersive transition effects with `flutter_staggered_animations` and Hero widgets for seamless navigation.
- **Responsive & Premium**: Crafted to feel like a high-end luxury application, optimized for clarity and ease of use.

### 🏘️ Smart Community Features
- **Digital Notice Board**: Instant dissemination of critical updates without paper clutter.
- **Complaint Resolution Engine**: Hero-animated tracking system for maintenance issues (Plumbing, Electrical, etc.).
- **Financial Transparency**: Clear view of maintenance dues and payment history via the "Bills" module.

---

## 👥 Role-Based Workflows

### 🏡 For Residents
- **Personalized Dashboard**: A "Bento" style command center for quick access to Complaints, Notices, and Bills.
- **Complaint Logging**: One-tap reporting for issues with real-time status tracking (Pending → Resolved).
- **Carousel Highlights**: Horizontal scroll for high-priority alerts and actions.
- **Integrated Profile**: Manage personal details and flat occupancy status seamlessly.

### 👮 For Admins (Committee)
- **Management Console**: Comprehensive overview of society health, total complaints, and active notices.
- **Broadcast Tools**: Professional tools to publish digital notices to the entire community instantly.
- **Issue Resolution**: Management interface to update, assign, and resolve resident complaints.
- **Security Control**: (Planned) Visitor gate pass generation and tracking.

---

## 🛠 Technical Architecture

- **Framework**: [Flutter](https://flutter.dev/) (Dart) for high-performance cross-platform development.
- **Backend Service**: [Firebase](https://firebase.google.com/) for serverless scalability.
  - **Authentication**: Secure Email/Password login with RBAC (Role-Based Access Control).
  - **Cloud Firestore**: NoSQL realtime database for instant data sync.
- **Styling**: Custom `ThemeData` implementation for seamless Light/Dark mode support.
- **Animations**: `flutter_staggered_animations` for cinematic entry effects.
- **Components**: Hand-crafted reusable widgets (`BentoItem`, `ComplaintCard`, `Carousel`) for visual consistency.

---

## 🚀 Installation & Setup

### 1. Requirements
- Flutter SDK 3.0+
- Android Studio / VS Code

### 2. Setup Configuration
*   **Android**: Place your `google-services.json` in `android/app/`.
*   **iOS**: Place your `GoogleService-Info.plist` in `ios/Runner/`.
*   *Note: These files are excluded from git for security.*

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run Application
```bash
flutter run
```

---

## 📊 Database Schema Overview

The platform uses a scalable Firestore schema including:
- **Users**: Managed roles (`admin`, `resident`) and profile data.
- **Complaints**: Detailed issue reports with categories, descriptions, and status flags.
- **Notices**: Broadcast messages with title, body, and timestamps.
- **Bills**: Financial records linking amounts due to specific residents.

---

## 📄 License
Distributed under the **MIT License**. See `LICENSE` for more information.

---

### 👨‍💻 Developed by
[Sanyasi Behera]
