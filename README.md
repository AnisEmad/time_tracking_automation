# Time Tracking Automation 🚀
An automated ETL pipeline to sync local productivity data with Google Sheets.

## Project Overview
This project was born out of a need to automate the tracking of my studying hours. Instead of manual logging, this system extracts data from the [Super Productivity app](https://github.com/super-productivity/super-productivity), processes it using Linux command-line tools, and synchronizes it with a Google Spreadsheet via a custom API.

## Key Features

- Automated ETL: Extracts, transforms, and loads data without manual intervention.

- Self-Healing Logic: Uses a "Catch-up" mechanism to ensure data is synced even if the machine was powered off during the scheduled time.

- Reliability: Integrated with system startup using cron and @reboot triggers.

- Environment Safety: Uses .env files to keep API keys and sensitive URLs secure.

