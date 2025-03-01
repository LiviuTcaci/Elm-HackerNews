# elm-hackernews-client

A Hacker News client built using Elm that fetches the top stories and displays them in a table with filtering and sorting capabilities.

## Features

- Fetch and display Hacker News top stories
- Sort posts by score, title, posting date, or no sorting
- Filter posts (show/hide job posts and text-only posts)
- Configurable number of posts to display (10, 25, or 50)
- Relative time display showing how long ago posts were created
- Responsive UI with clean layout

## Project Structure

```
src/
├── Cursor.elm            # Data structure for list navigation
├── Effect.elm            # Effect management for HTTP requests
├── Main.elm              # Application entry point
├── Model/                # Domain models
│   ├── Post.elm          # Post data structure and decoder
│   ├── PostIds.elm       # Post IDs data structure and operations
│   └── PostsConfig.elm   # Configuration for posts display
├── Model.elm             # Main application model
├── Reactor.elm           # For local development
├── Util/
│   └── Time.elm          # Time formatting utilities
└── View/
    └── Posts.elm         # Post table rendering
```

## Getting Started

### Prerequisites

- Node.js and npm
- Elm (0.19.1)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/elm-hackernews-client.git
cd elm-hackernews-client
```

2. Install dependencies:
```bash
npm install
```

### Running the Application

Start the Elm reactor:
```bash
elm reactor
```

Then open [http://localhost:8000/src/Main.elm](http://localhost:8000/src/Main.elm) in your browser.

### Working Offline

For offline development without the real Hacker News API:
```bash
npm run server
```

Then open [http://localhost:8000/src/Reactor.elm](http://localhost:8000/src/Reactor.elm) in your browser.

## Development

The application uses the Elm Architecture with:
- **Model**: Defines the application state
- **Update**: Handles messages and updates the model
- **View**: Renders the UI based on the current model
- **Commands**: Manages side effects like HTTP requests

## Testing

Run all tests:
```bash
npm test
```

To see your final grade:
```bash
npm run grade
```

## Key Components

- **Cursor**: Efficient data structure for navigating a list forward or backward
- **Post Table**: Displays posts with score, title, type, posting time, and link
- **Configuration Panel**: Allows customizing the posts display
- **Time Utilities**: Format timestamps and calculate relative time durations

## License

This project is provided as an educational resource with no specific license.
