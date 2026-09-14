EN | [RU](docs/README_RU.md)

## coinglance 📈

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![license](https://img.shields.io/badge/license-MIT-green?style=flat-square)

**Offline-first CoinGecko client** — Bitcoin & Toncoin in the app and on the home screen widget. No custom backend.

[Features](#-features) · [Setup](#-setup) · [Widgets](#-home-screen-widget) · [Architecture](#-architecture) · [Tests](#-tests)

---

## ✨ Features

| | |
|---|---|
| 📊 | **Rates** — BTC & TON: price, 24h change %, last updated |
| 🔄 | Pull-to-refresh; auto-refresh when cache is older than **5 min** |
| 💾 | **Drift** / SQLite cache for offline |
| 📱 | Home widget (Android + iOS template) via `home_widget` |
| ⚙️ | Quote currency **USD** / **EUR** |

CoinGecko public API is rate-limited (~10–30 req/min). Stale prices stay visible with a **Stale** badge when refresh fails.

---

## 🚀 Setup

```bash
git clone https://github.com/xvDoshik/coinglance.git
cd coinglance
flutter pub get
dart run build_runner build
flutter run
```

---

## 📱 Home screen widget

### Android

1. Install the app and open it once (or pull to refresh).
2. Home screen → Widgets → **CoinGlance**.

`CoinGlanceWidgetProvider` is registered in `AndroidManifest.xml`.

### iOS

1. Open `ios/Runner.xcworkspace` in Xcode.
2. **File → New → Target → Widget Extension** → name **CoinGlanceWidget**.
3. Use `ios/CoinGlanceWidget/CoinGlanceWidget.swift` as the widget source.
4. App Group **`group.com.coinglance.widget`** on Runner and the widget target.
5. Add the widget from the gallery.

---

## 🏗️ Architecture

```text
features/rates          → UI + Riverpod
data/                   → Drift + CoinGecko (Dio)
features/widget_bridge  → shared prefs for native widgets
domain/                 → CoinRate model
```

**Stack:** `flutter_riverpod`, `dio`, `drift`, `home_widget`, Material 3 dark theme.

---

## 🧪 Tests

```bash
flutter analyze
flutter test
```

---

## 📜 License

MIT — see [LICENSE](LICENSE).
