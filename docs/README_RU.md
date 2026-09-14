[EN](../README.md) | RU

## coinglance 📈

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![license](https://img.shields.io/badge/license-MIT-green?style=flat-square)

**Offline-first клиент CoinGecko** — Bitcoin и Toncoin в приложении и на home widget. Без своего бэкенда.

[Возможности](#-возможности) · [Установка](#-установка) · [Виджет](#-виджет-на-домашнем-экране) · [Архитектура](#-архитектура) · [Тесты](#-тесты)

---

## ✨ Возможности

| | |
|---|---|
| 📊 | **Курсы** — BTC и TON: цена, изменение за 24ч, время обновления |
| 🔄 | Pull-to-refresh; авто-обновление если кеш старше **5 мин** |
| 💾 | Кеш **Drift** / SQLite для офлайна |
| 📱 | Home widget (Android + шаблон iOS) через `home_widget` |
| ⚙️ | Валюта котировки **USD** / **EUR** |

Публичный API CoinGecko с лимитами (~10–30 запросов/мин). При ошибке сети показываются закешированные цены с бейджем **Stale**.

---

## 🚀 Установка

```bash
git clone https://github.com/xvDoshik/coinglance.git
cd coinglance
flutter pub get
dart run build_runner build
flutter run
```

---

## 📱 Виджет на домашнем экране

### Android

1. Установи приложение и открой его (или pull-to-refresh).
2. Домашний экран → Виджеты → **CoinGlance**.

`CoinGlanceWidgetProvider` уже в `AndroidManifest.xml`.

### iOS

1. Открой `ios/Runner.xcworkspace` в Xcode.
2. **File → New → Target → Widget Extension** → имя **CoinGlanceWidget**.
3. Подставь код из `ios/CoinGlanceWidget/CoinGlanceWidget.swift`.
4. App Group **`group.com.coinglance.widget`** для Runner и widget target.
5. Добавь виджет с домашнего экрана.

---

## 🏗️ Архитектура

```text
features/rates          → UI + Riverpod
data/                   → Drift + CoinGecko (Dio)
features/widget_bridge  → shared prefs для нативных виджетов
domain/                 → модель CoinRate
```

**Стек:** `flutter_riverpod`, `dio`, `drift`, `home_widget`, Material 3, тёмная тема.

---

## 🧪 Тесты

```bash
flutter analyze
flutter test
```

---

## 📜 Лицензия

MIT — см. [LICENSE](../LICENSE).
