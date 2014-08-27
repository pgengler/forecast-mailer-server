= Forecast Mailer =
Forecast Mailer is a small Rails app for managing getting weather forecasts mailed to you (or others) once a day.

== Data Source ==
The [forecast.io](http://forecast.io) API is used to provide the data.

== Dependencies ==
Since we use the "sidekiq" gem for backgrounding some work, you'll need a Redis server running on your system.

As written, mail is sent using SMTP through [Mandrill](http://mandrill.com/); you can either sign up for your own account or specify your own server.

