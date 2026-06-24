# Library Management System
A simple flask app to manage users along with mysql service

![Libray Management App - Flask](https://github.com/hamzaavvan/library-management-system/blob/master/ss/ss2.JPG?raw=true)


## Installation

To run the app flawlessly, satisfy the requirements
```bash
$ pip install -r requirements.txt
```

## Set Environment Variables
```bash
$ export FLASK_APP=app.py
$ export FLASk_ENV=development
```

## Start Server
```bash
$ flask run
```

Or run this command 
```bash
$ python -m flask run
```
# Docker Steps
To build Your Own Image
```bash
$ docker build -t Image-Name:tag .
Example: docker build -t ahmedafk404/lms:latest .
```

## Run Using Docker Compose
```bash
$ docker-compose up -d --build
```

## Run Project Using K8s with kind
I use kind with ingress.
It will create cluster and allow ingress request on port 80.
```bash
$ kind create cluster --config=k8s/kind-config.yml
```
### Install Ingress Controller
```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```
### To Run K8s Project
```bash
$ ./start-k8s.sh
```
### To Stop K8s Project
```bash
$ ./stop-k8s.sh
```


## To Run Project Using Helm Chart
You should run kind-config file and ingress command.
file flag is optional use it if you want to use customes files.
```bash
$ helm install lms-release .\lms-project\ -f .\lms-project\values.yam
```
## To Remove Project
```bash
$ helm uninstall lms-release
```