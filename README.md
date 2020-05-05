## A Jenkins image for building and testing Dockerized apps

Usage:
Before building this image you have to create 
a directory called: "secrets" and it should contain two files
called jenkins-user and jenkins-pass, this files are used for storing temporaly jenkins initial user credentials.

Example:
```bash
➜  flask-jenkins git:(master) ✗ tree secrets            
secrets
├── jenkins-pass
└── jenkins-user

0 directories, 2 files
➜  flask-jenkins git:(master) ✗ cat secrets/jenkins-user
admin
➜  flask-jenkins git:(master) ✗ cat secrets/jenkins-pass
admin
➜  flask-jenkins git:(master) ✗ 
```


Having secret folder ready, run:
```bash
docker-compose up
```
It will run a jenkins master instance and will bind it 
to port 8080 for web access and 50000 for jenkins slave communication.
