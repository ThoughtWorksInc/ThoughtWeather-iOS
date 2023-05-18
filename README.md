# ThoughtWeather
This is a simple iOS application that uses CoreLocation to determine the user's location, and then retrieves a weather
forecast for that location from https://openweathermap.org/ .

## Do This First
You'll need a free API key from https://home.openweathermap.org/users/sign_up .  After signup, provisioning takes
a few minutes, so it's a good idea to start by requesting your key.

## Tips/Tricks
To see the weather where you live, it's possible to change the virtual device location: In the Simulator application, simply select Features | Location

## The Brief
### We'll replace this with a proper README soon :)
Regarding the project of the 5th day, I was thinking of the cliche weather app.
We will need to prepare a project that will have a single view that calls an API and displays the weather for a specific area + a transition to another screen that has the app version or something basic.

Then we would ask them to achieve the following:
-Show in a list the upcoming 5 days. (Add API, tableview, MVVM).
-Make a details screen of a specific day where more info will be seen, autolayout should be used with constraints.
-Find an API that takes data, and make them submit the info to an API (POST request), for example an API that shares the weather to an email.

## Design Notes
- I'm planning to build out a complete, fully functioning app; and then remove enough code to make an exercise in completion.
- Current plan is to use https://openweathermap.org/ as a datasource.

## TODO
- Render five-day weather forecast for user's current location in WeekView
  - Possibly also add detailed current conditions?
- Segue to DayView when a WeekView cell is tapped
- Render detailed forecast for user's current location in DayView
- [maybe] Create a SwiftUI version in a different branch

