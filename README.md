# Forecast Mailer

Forecast Mailer is a small Rails API app for managing weather forecast email subscriptions. Subscribers receive a daily email with their weather forecast.

## Data Source

The [OpenWeatherMap](https://openweathermap.org/) API is used to provide forecast data.

## Tech Stack

- **Ruby 4.0** / **Rails 8.1** (API-only)
- **PostgreSQL 16** (shared Docker container on the `kamal` network)
- **Solid Queue** for background jobs (Postgres-backed, no Redis)
- **Solid Queue recurring tasks** for the daily scheduled email (replaces `whenever`)
- **Kamal 2** for deployment (nginx terminates SSL, proxies to a shared kamal-proxy on port 8081)
- **Thruster** as the in-container production proxy in front of Puma

## Configuration

Secrets are managed via Rails encrypted credentials (`config/credentials.yml.enc`).
The master key is in `config/master.key` (gitignored) or `RAILS_MASTER_KEY` env var.

Required credentials:

- `secret_key_base` — Rails secret key
- `smtp_username` / `smtp_password` — Mailgun SMTP credentials
- `google_maps_api_key` — Google Maps API key for geocoding
- `openweathermap_api_key` — OpenWeatherMap API key

Edit credentials with:

```
bin/rails credentials:edit
```

## Development

```
bin/setup
bin/rails server
```

You'll need a local PostgreSQL instance. The daily forecast email is sent via a
Solid Queue recurring task defined in `config/recurring.yml`.

## Deployment

Deployment is handled by Kamal 2. The app deploys as
`forecast-mailer.pgengler.net` on `hyperion.pgengler.net` (SSH user `apps`).

nginx terminates SSL and proxies to a shared kamal-proxy on host port 8081.
The app connects to the shared `postgres16` Docker container over the `kamal`
network.

Before deploying:

1. Fill in `.kamal/secrets` with `KAMAL_REGISTRY_PASSWORD`, `RAILS_MASTER_KEY`,
   and `DATABASE_URL`.
2. Ensure the `forecast_mailer` database and user exist in the `postgres16`
   container.
3. Ensure DNS for `forecast-mailer.pgengler.net` points to hyperion.

Deploy with:

```
bin/kamal deploy
```

**Do not** run `kamal proxy reboot` or `kamal setup` — the kamal-proxy is
shared with other apps and already running on port 8081.
