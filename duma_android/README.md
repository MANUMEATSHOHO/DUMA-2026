# ДУМА для Android

Обёртка WebView вокруг `index.html`. Игра работает полностью офлайн, разрешение INTERNET не запрашивается.
Ссылки (партии, источники) открываются во внешнем браузере. Двойное нажатие «Назад» закрывает игру.

## Как получить APK (без Android Studio)

1. Создайте репозиторий на github.com (можно приватный) и загрузите в него всё содержимое этой папки,
   включая скрытую папку `.github`.
2. Откройте вкладку **Actions → Build APK → Run workflow**.
3. Через 4–6 минут внизу страницы запуска появится артефакт **duma-android**: внутри `.apk` (для установки)
   и `.aab` (для Google Play). Шрифты сборка скачивает сама.

Без ключа APK подписан debug-ключом. Он ставится на телефон (разрешите установку из неизвестных источников),
но для RuStore и Google Play нужен свой ключ.

## Свой ключ подписи (один раз, и сохраните его копии: без него нельзя обновлять игру)

```
keytool -genkeypair -v -keystore duma-release.jks -alias duma -keyalg RSA -keysize 2048 -validity 10000
base64 -w0 duma-release.jks      # на Windows: certutil -encode, либо Git Bash
```

В репозитории: **Settings → Secrets and variables → Actions** и четыре секрета:
`KEYSTORE_BASE64` (вывод base64), `KEYSTORE_PASSWORD`, `KEY_ALIAS` (`duma`), `KEY_PASSWORD`.
Следующая сборка будет подписана вашим ключом.

## Сборка в Android Studio (альтернатива)

1. Положите шрифты: `cd app/src/main/assets/www/fonts && bash ../../../../../../tools/get-fonts.sh` (нужны Node.js и интернет).
2. Откройте папку в Android Studio, дождитесь синхронизации Gradle.
3. Build → Generate Signed App Bundle / APK.

## Что настроить

- Версия: `versionCode` / `versionName` в `app/build.gradle` (увеличивайте при каждом обновлении).
- Пакет: `com.manumgames.duma` (`app/build.gradle`, папка `java/...`, если захотите сменить).
- Шаг «Disable social links» в `.github/workflows/build-apk.yml` убирает блок с Telegram. Удалите шаг, если он нужен.
- Остальное перед публикацией: `docs/PUBLISHING_CHECKLIST.md`.
