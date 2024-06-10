# Fetch - iOS Coding Challenge

## Overview

Fetch is a native iOS application that allows users to browse and view recipes from TheMealDB API. This app focuses specifically on dessert recipes and provides detailed information about each dessert when selected.

## Features

- **Browse Desserts**: Fetches and displays a list of desserts from TheMealDB API, sorted alphabetically.
- **View Meal Details**: Provides detailed information about a selected meal, including the meal name, instructions, and ingredients/measurements.

## API Endpoints

The application utilizes the following API endpoints:

1. **Fetch Dessert List**
   - URL: `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert`
   - Purpose: To fetch the list of meals in the Dessert category.

2. **Fetch Meal Details**
   - URL: `https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID`
   - Purpose: To fetch the meal details by its ID.

## Project Structure

The project is organized into several folders to maintain a clean and scalable architecture using the MVVM (Model-View-ViewModel) pattern.

- **showMeals**: Contains all the files related to listing the meals.
- **showMeal**: Contains all the files related to the detailed view of a selected meal.
- **Service**: Contains the network service responsible for making API calls.

## Use Cases

Each use case acts as an individual service to handle network requests for specific functionalities:

- **ShowMealsUseCase**: Handles the network request to fetch the list of meals in the Dessert category.
- **ShowMealUseCase**: Handles the network request to fetch detailed information about a specific meal.

