# NetZilla - A Cyberpunk - Inspired Monsterverse Movie App

Welcome to a project that beautifully blends personal interest with technical growth, a passion project that I believe turned into a solid portfolio piece.


NetZilla is more than just a Netflix-style clone, it’s a vibrant, feature-rich SwiftUI app that showcases my journey through:

Clean **MVVM** architecture

Use of **local storage** for features like liking/favoriting movies

Advanced **SwiftUI animations**, layout techniques, and component composition

Deep use of property wrappers: @State, @Binding, @EnvironmentObject, @AppStorage

API-driven content via **async/await** and proper **concurrency** handling

User interaction feedback using **sound effects**

Filtering by genre and media type using enums, custom logic, and dynamic view updates

Modular and scalable UI using components like CarouselView, FilterBarView, and FeaturedMovieView

🎥 Favorite genre? MonsterVerse all the way. Had to sneak Godzilla and Kong in there.


#Technologies Used:

**SwiftUI** for all views and transitions

**Async/Await** for networking (replacing legacy Combine or closures)

Core Swift features like **Codable**, enums, and generics

@**MainActor** & @**Published** for safe state updates across the UI

**Custom ViewModifiers** and reusable components to keep code clean

**UserDefaults** for persistent likes


#Highlights:

Dynamic movie filtering by **TV Shows**, **Movies**, and **Genre**

Scrollable horizontal **carousels** with section headers

Full-screen movie detail view with overlay buttons

Fun touches like **sound playback** on play interaction

Cyberpunk-inspired color gradients and neon-themed UI


#Challenges and Learnings:

While I handled most of the app logic independently, I relied on external help for the genre filtering logic, especially coordinating selected values between the filter bar and the modal. I am planning to revisit this area with better architectural clarity in the future as it is a common feature across mobile apps, always room to grow!

#Reflection:

This project taught me a ton, not just about SwiftUI, but also about good UX design, state management, and balancing complexity with simplicity. I’m excited for what’s next. This is only the beginning.
