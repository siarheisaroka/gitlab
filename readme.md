# Django girls APP

I have is a partially working Django APP.

Here's what I did to fix it:

    1. Added DB connection settings to the APP.
    2. Added DB dependency modules to requirements.txt.
    3. Wrote a DB SQL init script.
    4. Wrote a start script for the APP.
    5. Wrote a script to create an admin user for the APP.
    6. Created a Dockerfile for the APP.
    7. Created a docker-compose file to start the DB and the APP.
    8. Spun up a GitLab runner on GCP and set it up as a shell executor.
    9. Connected the runner to GitLab.
    10. Fixed Python files for linter requirements.
    11. Wrote a CI pipeline to lint, build, test, and save the APP.