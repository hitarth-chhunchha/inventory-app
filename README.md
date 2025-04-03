# Inventory App Task

Inventory App Task

#### Run these commands:

1. `flutter pub get`
2. `dart run build_runner build --delete-conflicting-outputs`

## Testing Steps

- mobile: 9033006262
- password: eVital@12
- UTM Test
  Link: [https://example.com?utm_campaign=google_campaign&utm_source=google&utm_medium=google_page]

> File structure:

- constants
    - **app_strings**
    - **global** - App constant values
    - **storage_keys** - local storage related keys

- core
    - **models**
    - **themes** - app theme, colors, text styles
    - **enum**
    - **utils** - animation, dialog, loader, extension, validator
    - **widgets** - app widgets

- gen - assets generated files (fonts & images)

- pages
    - bloc (state, event & bloc class)
    - page

- repository
    - user_repository (generic class for handling user related methods)

- routes
    - **app_routes** - path names of screens
    - **app_pages** - router setup for navigation
    - **navigation_methods** - navigation extension

## References

- Dummy user data generate with chatgpt
- UI reference from figma community free
  templates [https://www.figma.com/community/file/970446353087158834/splash-screen-app-launch-screen-freebies-app-design-atik-gohel, ]

## Development SDK

- Flutter 3.29.2
- Dart 3.7.2