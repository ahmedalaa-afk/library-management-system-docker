#!bin/bash
kubectl apply -f k8s/ingress.yml
kubectl apply -f k8s/nginx-config.yml
kubectl apply -f k8s/db-config.yml
kubectl apply -f k8s/mysql-deployment.yml
kubectl apply -f k8s/phpmyadmin-deployment.yml
kubectl apply -f k8s/lms-deployment.yml