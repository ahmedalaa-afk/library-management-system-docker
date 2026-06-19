#!bin/bash
kubectl delete -f k8s/nginx-config.yml
kubectl delete -f k8s/db-config.yml
kubectl delete -f k8s/mysql-deployment.yml
kubectl delete -f k8s/phpmyadmin-deployment.yml
kubectl delete -f k8s/lms-deployment.yml