# CI/CD Deployment on Amazon EKS

This project demonstrates a production-style CI/CD pipeline using Jenkins,
Docker, and Kubernetes (Amazon EKS).

## Architecture
GitHub → Jenkins → Docker Hub → Amazon EKS

## Pipeline Flow
1. Code pushed to GitHub
2. Jenkins builds Docker image
3. Image pushed to Docker Hub
4. Jenkins deploys application to EKS using kubectl

## Kubernetes Resources
- Deployment (2 replicas)
- Service (LoadBalancer)

## Access Application
Run:
kubectl get svc prod-app-service

Use the LoadBalancer EXTERNAL-IP in a browser.
