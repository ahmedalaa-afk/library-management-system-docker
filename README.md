# Library Management System
A simple flask app to manage users along with mysql service
You will find all test domains in ingress files.

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
$ kind create cluster --config=kind/kind-config.yml
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
$ helm install lms-project lms-project/ -f lms-project/values.yaml
```
check if all pod running
```bash
$ kubectl get pod
```
## To Remove Project
```bash
$ helm uninstall lms-release
```

## To Install Prometheus and Grafana Using Helm Chart
```bash
$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
$ helm install prometheus prometheus-community/kube-prometheus-stack -n prometheus --create-namespace
```

## To Install mysql exporter Using Helm Chart
```bash
$ helm install mysql-exporter prometheus-community/prometheus-mysql-exporter -f lms-project/mysql-exporter-values.yaml
```
To Configure prometheus with ingress
```bash
$ kubectl.exe apply -f .\prometheus-grafana\prometheus-ingress.yml
```
To connnect prometheu with lms app we use service monitor
```bash
$ kubectl.exe apply -f .\prometheus-grafana\lms-service-monitor.yaml
```
check if all pod in prometheus are running
```bash
$ kubectl get pod -n prometheus
```
Get your grafana admin user password by running:
```bash
$ kubectl get secret --namespace prometheus -l app.kubernetes.io/component=admin-secret -o jsonpath="{.items[0].data.admin-password}" | base64 --decode ; echo
```
## To Install argocd Using Helm Chart
after install argocd chart and configuration file restart it.
I try in local environment so change configmap file to make http work.
```bash
$ helm repo add argo https://argoproj.github.io/argo-helm
$ helm install argocd argo/argo-cd -n argocd --create-namespace
$ kubectl apply -f argocd/argocd-config.yml -f argocd/argocd-ingress.yml
$ kubectl rollout restart deployment argocd-server -n argocd
```
To Get argocd admin password
```bash
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
If you want to connect argocd with git run this file.
```bash
$ kubectl apply -f argocd/nginx.yml
```