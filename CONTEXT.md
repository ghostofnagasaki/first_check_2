# SmartSaver (a.k.a. SaveSmart) 🇯🇲
> **Tagline**: "Money management made simple. Yow, watch yuh budget!"

## 1. Project Overview
Build a cross-platform (Android + iOS) Flutter mobile application called **SmartSaver**. This is a fintech/personal finance MVP designed to help users manage their spending relative to a defined budget. It features real-time budget tracking, location-based shopping alerts, receipt scanning via OCR, and a "Jamaican-friendly" user experience.

### Key Goals
- **Budget Control**: Users set a periodic budget (monthly MVP) and track spending against it.
- **Smart Alerts**: Geolocation detects proximity to stores to prompt cart usage; visual/audio warnings when budget is nearly depleted.
- **Ease of Use**: Quick manual entry or camera-based receipt scanning to add items.
- **Tech Excellence**: Demonstrate a production-grade 2026 Flutter architecture (Zustand, Supabase, ML Kit).

---

## 2. Tech Stack & Architecture
This stack is chosen for performance, scalability, and modern best practices (Flutter 3.24+ / Dart 3.5+).

| Component | Library / Tool | Notes |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.24+ | Dart 3.5+ |
| **State Management** | `flutter_zustand` | Hook-based, lightweight, reactive stores. **No Provider/Riverpod**. |
| **Backend / Auth** | `supabase_flutter` | Authentication, Postgres Database, Storage (Receipts). |
| **OCR** | `google_mlkit_text_recognition` | On-device processing. No cloud API dependnecy. |
| **Navigation** | `go_router` (Recommended) | Or standard Navigator 2.0. |
| **Dependency Injection** | `get_it` | Lightweight service locator. |
| **Networking** | `dio` or Supabase Client | For any external API calls. |
| **Location** | `geolocator`, `google_maps_flutter` | User position & store proximity detection. |
| **Notifications** | `flutter_local_notifications` | Local alerts for budget thresholds. |
| **Camera** | `camera`, `image_picker` | Receipt capture. |
| **I18n / Parsing** | `intl` | Currency formatting (JMD support). |
| **UI Kit** | Material 3 | Custom theming for a clean fintech look. |

---

## 3. Core Features (MVP)

### 3.1. Authentication & User Profile
- **Supabase Auth**: Email/Password or Social Login (Google).
- **Secure Storage**: Persist session safely.

### 3.2. Budget Management
- **Set Budget**: Users input a daily/weekly/monthly limit (e.g., $50,000 JMD).
- **Dashboard**: Visual progress bar showing:
  - Total Budget
  - Amount Spent
  - Remaining Balance (Red alert if < 20%).

### 3.3. Virtual Shopping Cart
- **Active Cart Mode**: Users start a "trip".
- **Real-time Calc**: As items are added, the "Remaining Budget" updates instantly.
- **Entry Methods**:
  1.  **Manual**: Name, Price, Quantity.
  2.  **Scan**: Camera capture -> OCR -> Auto-populate list.
- **Feedback**: "Warning: Cart total is 90% of your remaining funds!"

### 3.4. Smart Location (Geo-fencing)
- **Detection**: Detect if user is near a supermarket/store (using Google Places API or hardcoded Kingston zones for MVP).
- **Prompt**: "Looks like you're shopping. Start a cart?"

### 3.5. History & Analytics
- **Cart History**: View past shopping trips, totals, and receipt images.
- **Data Persistence**: Sync all transactions to Supabase `carts` and `cart_items` tables.

---

## 4. Database Schema (Supabase)

### `profiles`
- `id` (uuid, PK)
- `email`
- `monthly_budget` (numeric)
- `created_at`

### `carts`
- `id` (uuid, PK)
- `user_id` (fk -> profiles.id)
- `store_name` (text, optional)
- `total_amount` (numeric)
- `created_at` (timestamp)
- `receipt_img_url` (text, optional)

### `cart_items`
- `id` (uuid, PK)
- `cart_id` (fk -> carts.id)
- `item_name` (text)
- `price` (numeric)
- `quantity` (int)

---

## 5. Development Phase Plan (Step-by-Step)

### Phase 1: Foundation & Setup
1.  **Project Init**: `flutter create`, configure `pubspec.yaml` with all dependencies.
2.  **Supabase Config**: Set up project in Supabase dashboard, get URL/Anon Key, configure `.env`.
3.  **Architecture Scaffold**: Setup `get_it`, `flutter_zustand` StoreScope, and folder structure.

### Phase 2: State Management & Auth
1.  **Stores**:
    - `AuthStore`: Handle session, login, logout.
    - `BudgetStore`: Manage budget limits and current monthly spend.
2.  **UI**: Login Screen, Loading Screen, basic Home Dashboard.

### Phase 3: The Cart System
1.  **CartStore**: Logic for adding items, removing items, calculating totals, computing "remaining budget".
2.  **UI**: Active Cart Screen.
    - Floating Action Button to "Add Item".
    - List view of current items.
    - Live "Remaining" indicator.

### Phase 4: OCR & Camera
1.  **Service**: Implement `OcrService` using ML Kit.
2.  **Flow**: Camera Button -> Capture -> Parse Text -> Regex for Prices -> Add to `CartStore`.

### Phase 5: Location & Notifications
1.  **Geolocator**: Background permission setup.
2.  **Logic**: Check coordinates against dummy list of stores (e.g., Sovereign Centre, MegaMart).
3.  **Alerts**: Trigger local notification if budget < 20% or if near store.

### Phase 6: Polish & History
1.  **History Screen**: Fetch and display past carts from Supabase.
2.  **Styling**: Apply "Clean Fintech" theme with Jamaican currency formatting.
3.  **Testing**: Widget tests for Cart logic.

---

## 6. Code Style & Standards
- **Strict Typing**: No `dynamic` unless absolutely necessary.
- **Comments**: Heavy documentation on "business logic" (e.g., the budget subtraction algorithm, OCR regex).
- **Error Handling**: User-friendly error messages (Snackbars), not app crashes.
- **UX Copy**: Friendly, colloquial Jamaican phrasing where appropriate ("Yuh spendin' too fast!").
