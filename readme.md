Django girls APP

What I have is a partially working Django app.

Here's what I did to fix it:

    Added DB connection settings to the app.
    Added DB dependency modules to requirements.txt.
    Wrote a DB SQL init script.
    Wrote a start script for the app.
    Wrote a script to create an admin user for the app.
    Created a Dockerfile for the app.
    Created a docker-compose file to start the DB and the app.
    Spun up a GitLab runner on GCP and set it up as a shell executor.
    Connected the runner to GitLab.
    Fixed Python files for linter requirements.
    Wrote a CI pipeline to lint, build, test, and save the app.
