# Skillbox tasks

- **Task 1 - [branch task01](https://gitlab.skillbox.ru/sergei_soroka/devops-engineer-basics/-/tree/task01)**
- **Task 2 - [branch task02](https://gitlab.skillbox.ru/sergei_soroka/devops-engineer-basics/-/tree/task02)**

Directory stucture:
```
├── docker_inst.sh - docker install script example for runner
├── install-runner.sh gitlab runner install script example 
├── readme.md- current file
├── run-before-shutdown.service - unregister runner service example
├── unreg_runner.sh - unregister runner script example
├── tf-install.sh - terraform install script example
├── start.sh - startup script example for runners
├── tf.runner               - Create external gitlab runner on GCP
│   ├── application.tf      - statefull MiG for runner
│   ├── data.tf             - external datasource
│   ├── locals.tf           - locals
│   ├── root.tf             - provider settings
│   ├── start.sh            - startup shell script
│   ├── start.tpl           - startup shell script template
│   ├── terraform.tfvars    - variables values
│   └── vars.tf             - variables 
├── tf.stage                - Create external stage app server on GCP
│   ├── application.tf      - statefull MiG for stage app server
│   ├── data.tf             - external datasource
│   ├── locals.tf           - locals
│   ├── outputs.tf          - outputs
│   ├── root.tf             - provider settings
│   ├── start.sh            - startup shell script
│   ├── start.tpl           - startup shell script template
│   ├── terraform.tfvars    - variables values
│   └── vars.tf             - variables
```
