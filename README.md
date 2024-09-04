# Cinema App

**Cinema** is a Flutter application that integrates with the TMDB API to display and manage movie data. The app features trending movies, upcoming releases, search functionality, movie details, favorite movies, genre preferences, and a map showing nearby theaters. The app uses GetX for state management and includes embedded YouTube trailers for movies.

## Features

- **Trending Movies**: View a list of trending movies with details like title, release date, and genre.
- **Search**: Search for movies by title and view detailed results.
- **Movie Details**: View detailed information about selected movies, including a trailer.
- **Favorites**: Mark movies as favorites and access them offline.
- **Genre Preferences**: Filter movies based on your preferred genres.
- **Map Integration**: View nearby theaters on a map with markers.
- **YouTube Trailers**: Watch movie trailers directly in the app.


## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- A valid API key from [TMDB](https://www.themoviedb.org/documentation/api).
- A Google Maps API key for map integration

### Setup

1. **Clone the repository**:
   ```bash
https://github.com/Zobayer-Mahmud/cinema.git
   cd cinema-app
2.Install dependencies:
```bash
      flutter pub get
      
3.** Configure API keys**:
Replace YOUR_API_KEY with your TMDB API key in movie_service.dart.
Replace YOUR_GOOGLE_MAPS_API_KEY with your Google Maps API key if using Google Maps.
Run the app:

```bash 
flutter run
4. Project Structure
plaintext
Copy code

lib/
├── app/
│   ├── api/
│   │   ├── api_client.dart              # Handles API requests
│   │   └── service.dart                 # Service layer for API interactions
│   ├── base/
│   │   ├── baseview.dart                # Base view for screens
│   │   ├── basecontroller.dart          # Base controller for managing state
│   │   └── shared_controller.dart       # Shared controller across modules
│   ├── common/
│   │   ├── api_endpoint.dart            # API endpoint constants
│   │   ├── app_color.dart               # Application color definitions
│   │   └── app_const.dart               # Application constants
├── data/
│   └── responsemodel.dart               # Data models for API responses
├── modules/
│   ├── home/
│   │   ├── view/                        # Home screen UI components
│   │   ├── controller/                  # Controllers for home screen
│   │   ├── bindings/                    # Bindings for home module
│   │
│   ├── details/
│   │   ├── view/                        # Movie details UI components
│   │   ├── controller/                  # Controllers for movie details
│   │   ├── bindings/                    # Bindings for details module
│  
│   ├── favorites/
│   │   ├── view/                        # Favorites UI components
│   │   ├── controller/                  # Controllers for favorites
│   │   ├── bindings/                    # Bindings for favorites module
│   │   ├── routes/                      # Routing for favorites module
│   │  
│   ├── map/
│   │   ├── view/                        # Map view for showing nearby theaters
│   │   ├── controller/                  # Controllers for map view
│   │   ├── bindings/                    # Bindings for map module
│   │   
│   │  
├── main.dart                            # Main entry point for the app
├── di.dart                            # Dependency injection for details module
└── README.md                            # This file

5.state Management
The app uses GetX for state management, dependency injection, and routing. Controllers manage the state of different parts of the app, and Obx is used for reactive UI updates.

6.API Information
TMDB API:

Base URL: https://api.themoviedb.org/3



7. Google Maps for displaying nearby theaters.
Overpass API used with OpenStreetMap for finding nearby theaters.