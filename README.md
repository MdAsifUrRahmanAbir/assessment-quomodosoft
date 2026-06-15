# QuomodoSoft Service Store & Influencer Portal - Flutter Mobile Client

A modern, highly modular, and feature-rich Flutter application built adhering to **Clean Architecture** and **BLoC/Cubit State Management** guidelines. All UI screens have been designed as pure `StatelessWidget` structures with separate, single-responsibility sub-widgets (strictly under 100 lines of code per file) for optimal performance and easy maintenance.

---

## 🌟 Key Features & Completed Modules

### 1. Authentication (`Sign In`)
- **UI Design**: Modern, premium slate-based input forms with hidden/obscured password options, remember me toggle, and redirect triggers.
- **State Management**: Governed by `SignInCubit` which handles input validation, validation states, submission events, and auto-saves auth tokens.
- **API Integration**: Integrates directly with the `store-login` POST endpoint.

### 2. Main Dashboard (`Home`)
- **UI Design**: Premium wave header backgrounds, custom dashed dividers, balance displays, and quick-access withdrawal cards.
- **Stats Grid**: Displays key metrics (Active orders, pending orders, complete orders, total services, today earnings, total earnings).
- **Recent Transactions**: Lists transaction histories (Withdrawals, PayPal payments, etc.) in clean, custom list tiles.

### 3. Service Listing
- **Pagination & Scroll Listener**: Uses a stateless `ScrollNotification` listener to auto-load paginated results when the user scrolls near the bottom of the list.
- **Service Cards**: Premium card displays containing ratings, review counts, active/inactive badges, prices, and shortcut actions (edit/delete).
- **Empty State**: Fallback design is displayed if no services exist on the account.

### 4. Service Details
- **Parallax Image Header**: Interactive expanded header image showing price tags and active status tags.
- **Dynamic Content**: Displays detailed category pathing, description copy, check-marked feature lists, and quick-action footers.

### 5. Create Service (`Add New Services`)
- **Multipart Upload**: Supports creating a service and uploading a selected header image from the device's gallery (`image_picker` integration) using `multipart/form-data`.
- **Dynamic Features**: Add or remove package feature fields on the fly dynamically.

### 6. Update Service (`Edit Services`)
- **Synchronous Initialization**: Form inputs (name, price, description, images, features) are pre-filled synchronously in `initState` from route arguments to prevent flickering on first load.
- **Laravel Method Spoofing**: Fully integrates Laravel PUT method-spoofing by sending updates via a `POST` request with the `_method=PUT` parameter.
- **Dynamic Image Swapping**: Conditional file upload triggers only when a new image is selected.

---

## ⚙️ Completed API Integrations List

All integrations are located under `ServiceRemoteDatasource` and `AuthRemoteDatasource`:

| Feature | HTTP Method | Endpoint Path | Content Type | Notes |
| :--- | :--- | :--- | :--- | :--- |
| **Login** | `POST` | `api/store-login?lang_code=en` | `application/json` | Saves user details locally. |
| **Get Services** | `GET` | `api/influencers/service?lang_code=en&page={page}` | `application/json` | Includes pagination support. |
| **Service Details** | `GET` | `api/influencers/service/{id}?lang_code=en` | `application/json` | Fetches translations and feature details. |
| **Create Service** | `POST` | `api/influencers/service?lang_code=en` | `multipart/form-data` | Uploads local images & text fields. |
| **Update Service** | `POST` | `api/influencers/service/{id}?lang_code=en&_method=PUT` | `multipart/form-data` | Laravel PUT method spoofing. |
| **Delete Service** | `DELETE` | `api/influencers/service/{id}?lang_code=en` | `application/json` | Removes the service permanently. |
| **Get Categories** | `GET` | `api/influencers/service/create?lang_code=en` | `application/json` | Populates category drop-down forms. |

---

## 📂 Highly Modular Directory Architecture
All presentation layers are structured into single-responsibility stateless components under 100 lines:

```
lib/
├── core/
│   ├── constants/       # AppColors, AppSizes, AppAssets
│   ├── di/              # GetIt dependency injection registry
│   ├── routes/          # Navigation paths (AppRoutes)
│   └── services/        # ApiServices, LocalStorage, AppSnackBar
├── data/
│   ├── datasource/      # ServiceRemoteDatasourceImpl, AuthRemoteDatasourceImpl
│   └── models/          # ServiceModel, UserModel
├── domain/
│   ├── entities/        # ServiceEntity, CategoryEntity, UserEntity
│   └── usecases/        # GetServices, CreateService, UpdateService, DeleteService
└── presentation/
    ├── bloc/            # ServiceCubit, SignInCubit
    ├── widgets/         # AppBottomNavBar, ServiceCard, PrimaryButton
    └── screens/
        ├── dashboard/      # Stateless main screen & isolated cards widgets
        ├── service_list/   # Stateless list, pagination, and empty state widgets
        ├── service_details/# Parallax details header, description, features widgets
        ├── create_service/ # Multi-source file picker & dynamic feature controllers
        ├── update_service/ # Synchronous form matching & Laravel spoofing fields
        └── sign_in/        # Sign-in form fields, remember checkbox, footer widgets
```

---

## 🚀 How to Run the Project

1. **Get Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run All Verification Tests**:
   ```bash
   flutter test
   ```

3. **Run the Application**:
   ```bash
   flutter run
   ```
