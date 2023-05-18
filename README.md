# ThoughtWeather
## About
This is a simple iOS application that uses CoreLocation to determine the device location, and then retrieves a weather
forecast for that location from https://openweathermap.org/ .  At the moment it's pretty bare-bones, leaving plenty of room for enhancement and experimentation.  Hopefully you can have some fun with it!

## Do This First
You'll need a free API key from https://home.openweathermap.org/users/sign_up .  After signup, provisioning takes
a few minutes, so it's a good idea to start the day by requesting your key.  
(once you have a key, you can add it to the `Config.appId` property in the codebase, currently marked )

There isn't any more setup required.  You should be able to open `ThoughtWeather.xcodeproj` and build, test, or run the app without any additional steps.

## About the Codebase
We've started building a small weather app, and we've tried to demonstrate some important iOS patterns and practices, including:
- Protocol-oriented programming
- Unit testing
- Lightweight data stubbing
- Separation of responsibility between DTO and domain objects
- `CoreLocation`
- `URLSession` and `Codable` for network requests
- MVVM
- `async`/`await`
- Combine

Although we consider this app to be a reasonably well-factored demo, much work remains before it would be Production-ready.  In addition to needing a much more compelling user experience, production-readiness concerns not yet addressed include:
- Accessibility
- Internationalization
- Full unit test coverage
- Higher-order tests
- Graceful error handling
- etc

## Tips/Tricks
- To see the weather where you live, it's possible to change the virtual device location: In the Simulator application, simply select Features | Location .
- The `ForecastResponse` DTO was created using https://quicktype.io, which is a really handy tool for quickly generating `Codable`-conformant Swift DTOs from a sample JSON payload.  
- Your feedback is very welcome.  Please feel free to reach out to the maintainers, open a GitHub issue, or raise a pull request if you see opportunities for improvement.

### Enjoy!
-- Ephrem Beaino, ephrem.beaino@thoughtworks.com  
-- Michael Chaffee, mchaffee@thoughtworks.com  