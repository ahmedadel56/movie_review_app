# Movie Review App 🎬

A Ruby on Rails application that displays movies and their associated reviews, allowing users to:
- View all movies with their details
- Search movies by actor name
- Sort movies by average rating
- See movie metadata (year, director, actors)
- View star ratings and review counts

---

## 📋 Features

- **Actor Search**: Filter movies by actor name
- **Rating Sort**: Sort movies from highest to lowest (or vice versa) by average rating
- **Responsive UI**: TailwindCSS-powered modern design
- **Pagination**: 10 movies per page
- **Cached Ratings**: Efficient average rating and review count calculation

---

## 🛠️ Requirements

- Ruby 3.4.4
- Rails 8.0.2
- PostgreSQL 9.3+
- Node.js (for TailwindCSS)
- Yarn/npm (for TailwindCSS)

---

## 📦 Installation

```bash
# Clone repository
git clone https://github.com/yourusername/movie-review-app.git 
cd movie-review-app

# Install dependencies
bundle install
yarn install

# Setup database
rails db:create db:migrate

# import all data
rake import:data