# Task02


## Task condition:

+ Create and register your own GitLab runner.
+ Add a step for deploying to the server to your pipeline.
+ Enable automatic refreshing of the web page.
+ Add a command to your pipeline for archiving your application and place the archive on a web server for downloading.
+ Save all pipeline changes in your repository.
+ Send the link to your repository and the archive file on your web server 



## Solution:

Directory stucture
```
├── 02_Continuous_Delivery      - initial task directory
│   └── html                    - web site content files
├── Dockerfile                  - Dockerfile for web server
├── docker-compose.yaml         - Docker-compose file for starting a web server
├── readme.md                   - This readmi file
└── test_app.sh                 - Shell script for the testing the web server
```

The stage runner is placed on a spot computing instance, which means it can be stopped and restarted at any time, resulting in a potential IP address change. To get the link to the archive, check the log of the 'archive_on_stage' pipeline job. If the link is not working, simply re-run the job to get the latest IP address.

*Note: All infrastructure deployment Terraform files are located in the master branch.*
