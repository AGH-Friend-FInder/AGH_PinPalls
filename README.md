# AGH PinPals
Aplikacja mobilna **AGH PinPals** jest idealną aplikacją mobilną dla studentów szukających przyjaciół na Kampusie AGH!

## Wizja

### Znajdź znajomych na MS AGH

Studenci AGH niemal codziennie znajdują się w zatłoczonych przestrzeniach, zarówno na terenie Miasteczka Studenckiego, jak i poza nim. W takich warunkach często trudno jest się efektywnie zlokalizować podczas spotkań towarzyskich.

Nasza aplikacja udostępnia użytkownikom mapę Miasteczka Studenckiego, na której mogą umieszczać pinezki ze swoją lokalizacją, co znacząco ułatwi znalezienie ich na miasteczku. W pinezce można znaleźć informacje o:

- czasie dodania pinezki,
- ilości osób, które są obecnie w danej lokalizacji,
- osobie, która dodała pinezkę.

Pinezki można filtrować na podstawie różnych tagów, które można dodać w trakcie jej dodawania. Dodatkowo oferujemy też możliwość dodania prywatnych pinezek, widocznych tylko dla konkretnych grup użytkowników.

### Najważniejsze wydarzenia na Kampusie AGH

W AGH-PinPals dostępna jest również mapa Kampusu AGH z zaznaczonymi aktualnie odbywającymi się wydarzeniami. Pozwala ona użytkownikom znaleźć ciekawe eventy w okolicy, jak i również aktualnie trwające promocje w lokalach gastronomicznych.

Oprócz tego, w AGH-PinPalls znajduje się też lista odbywających się w najbliższym czasie wydarzeń, która pozwoli użytkownikom na planowanie przyszłych wypadów.

## Opis zastosowanych technologii

### Informacje techniczne

W aplikacji wykorzytano technologie:

- Flutter
- Dart
- Spring Boot
- MySQL

Aplikacja AGH-PinPals jest kompatybilna z systemami **Android**

## Instrukcja uruchomienia
### Java 21
Do kompilacji serwera i aplikacji mobilnej potrzebujemy Javy 21. Można ją pobrać np. [tutaj](https://www.oracle.com/pl/java/technologies/downloads/#java21)
Możemy zweryfikować posiadaną wersję Javy poprzez: `java --version`

![java_version](https://github.com/user-attachments/assets/1dcf3c96-0b2d-4706-af32-c28d35fd2fce)

### Aplikacja androidowa
1. Instalacja [fluttera](https://docs.flutter.dev/get-started/install/)
   - weryfikacja instalacji `flutter --version`
   - weryfikacja potrzebnych narzędzi `flutter doctor`
  ![flutter_doctor](https://github.com/user-attachments/assets/80d341ea-21cd-4d8d-a2a5-e7e7cb1dbe7c)
2. Android SDK
   - najłatwiej androidowe sdk pobrać razem z [Android Studio](https://developer.android.com/studio?hl=pl)
   - po instalacji możemy zweryfikować czy polecenie `flutter doctor` wykrywa android sdk. Prawdopodobnie będzie narzekał na brak command-line tools.
   - w menu startowym Android Studio należy rozwinąć "More Actions" i wejść w "SDK Manager". Tam z zakładki SDK Tools należy wybrać i zainstalować "Android SDK command-line Tools (latest)"
   ![cmdline_tools](https://github.com/user-attachments/assets/aa707172-2cf8-4d7c-bd8f-f310d4c5a859)
   - następnie musimy zaakceptować licencje androida `flutter doctor --android-licenses`
   - teraz flutter doctor nie powinien już na nic narzekać. 
4. Zbudowanie aplikacji mobilnej:
```
git clone https://github.com/AGH-Friend-FInder/agh_pin_palls
cd agh_pin_palls

flutter build apk --release
```
Zbudowany plik .apk do wgrania na telefon lub emulator znajdziemy w folderze wypisanym pod koniec budowy aplikacji. U nas `agh_pin_palls/build/app/outputs/flutter-apk/app-release.apk `
5. Aby uruchomić aplikację w emulatorze w Android Studio musimy otworzyć sklonowane repo w IDE, a następnie:
   - pobrać plugin Fluttera
   - pobrać [Dart SDK](https://dart.dev/get-dart#install)
   - skonfigurować SDK w Android Studio (Settings > Languages & Frameworks > Dart)
     - Enable Dart support for the project agh_pin_palls
     - Dart SDK Path  
### Serwer backend
```
git clone https://github.com/AGH-Friend-FInder/server
cd server

./gradlew run
```
## Opis procesu powstawania projektu
Piatek:
1. Burza mózgów
2. Ustalanie wspólnej wizji aplikacji
3. Ustalenie poczatkowych zadań i podział pracy
4. Setup środowiska i research

Sobota:
5. Ustalenie priorytetów i podział pracy według wiedzy (Stand up)
6. Wykonywanie przydzielonych zadań ( Frontend i backend) + dyskusje na temat dokładnego działania i celu aplikacji
7. Pierwsze próby łączenia backendu i frontendu
8. Podsumowanie dnia i wykonanych zadań

Niedziela:
9. Szybkie podsumowanie zadan wykonanych + ustalenie priorytetów (Tabelka z checklistą funckjonalności)
10. Podział pracy ( łączenie backendu i frontendu, próby hostowania bazy i serwera)
11. Zrezygnowanie z pobocznych funkcjonalności
12. Testowanie aplikacji i wykrywanie błędów do poprawy
13. Tworzenie prezentacji i planu live demo



## Wyzwania i problemy
- Problemy z linkowaniem frontendu z bazą danych.

- Trudności z logowaniem i rejestracją.

- Komunikacja między zespołami backendu i frontendu.

- Niepotrzebne poświęcanie czasu na mało istotne funkcje.

- Problemy z wydajnością bazy danych podczas testów obciążeniowych

## Elementy technicznej dokumentacji

### Endpointy REST API

Endpointy oraz ich przykładowe żądania i odpowiedzi zostały szczegółowo opisane w pliku [`README.md`](https://github.com/AGH-Friend-FInder/server/blob/master/README.md).  

### Wzorce i rozwiązania techniczne

- **DTO (Data Transfer Object)**  
  Klasy `UserDTO`, `GroupDTO` i inne oddzielają dane transferowane przez API od modeli domenowych – poprawia to bezpieczeństwo i modularność kodu.

- **Dependency Injection (DI)**  
  Spring automatycznie wstrzykuje zależności za pomocą adnotacji `@Autowired`, co pozwala łatwo zarządzać komponentami i ogranicza sprzężenie.

- **Repository Pattern z JPA**  
  Dostęp do danych odbywa się przez interfejsy repozytoriów (`UserRepository`, `GroupRepository` itd.) wykorzystujące mechanizmy ORM.

- **ORM z wykorzystaniem JPA**  
  Modele takie jak `User`, `Group` oraz `CurrentPins` zostały odwzorowane jako encje JPA, umożliwiając mapowanie obiektów Java bezpośrednio na tabele relacyjnej bazy danych.

### Baza danych

System korzysta z relacyjnej bazy danych **MySQL**, która została zhostowana za pomocą platformy [Aiven Console](https://console.aiven.io).  
Połączenie z bazą jest skonfigurowane w pliku `application.properties`.

**Uwaga bezpieczeństwa:**  
Ze względu na charakter projektu (hackathon), dane dostępowe do bazy zostały wypuszczone bezpośrednio w repozytorium. Jesteśmy świadomi, że jest to **zła praktyka bezpieczeństwa** – w środowisku produkcyjnym należy bezwzględnie unikać takich rozwiązań.

### Schemat bazy danych

Poniżej znajduje się diagram ilustrujący strukturę bazy danych (tabele, klucze obce, relacje):

![image](https://github.com/user-attachments/assets/ad258f52-6844-48e3-ab28-b3780aa3cd8f)

Diagram zawiera m.in.:
- tabele: `users`, `groups`, `current_pins`
- relacje many-to-many pomiędzy `users` a `groups`, oraz `groups` a `current_pins`


## Podsumowanie
Co poszło dobrze:

- Efektywny podział pracy.

- Utrzymanie porządku w repozytorium kodu.

- Zbudowanie solidnej podstawy aplikacji.

Problemy:

- Backend i frontend wymagały dodatkowej pracy nad integracją.

- Problemy z wydajnością bazy danych podczas testów obciążeniowych.


