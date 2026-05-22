# Simple Web App Deployment Guide

This guide shows how to deploy and access the simple web application using the Helm chart.

## Prerequisites

- Kubernetes cluster running (Minikube, Docker Desktop K8s, or cloud K8s)
- Helm 3+ installed
- kubectl configured

## Quick Start

### 1. Deploy the Application

```bash
# Clone/navigate to the repository
cd common-helm-chart

# Deploy the simple web app
helm install simple-app ./ -f examples/simple-web-app.yaml

# Verify deployment
kubectl get pods
kubectl get svc
```

### 2. Access via Browser

The service uses **NodePort** type, which means you can access it directly:

#### Option A: Minikube
```bash
# Get the Minikube IP
minikube ip

# Open in browser
# http://<MINIKUBE-IP>:30080
# Example: http://192.168.99.100:30080
```

#### Option B: Docker Desktop Kubernetes
```bash
# Access directly
# http://localhost:30080
```

#### Option C: Cloud Kubernetes (AWS EKS, GCP GKE, etc.)
```bash
# Get external IP
kubectl get svc simple-app

# Open in browser
# http://<EXTERNAL-IP>:80
```

#### Option D: Port Forwarding (All Clusters)
```bash
kubectl port-forward svc/simple-app 8080:80 &

# Then open: http://localhost:8080
```

### 3. Monitor the Service

```bash
# Check pod status
kubectl get pods -w

# View logs
kubectl logs -f deployment/simple-app

# Describe pod for details
kubectl describe pod <pod-name>
```

### 4. Clean Up (After 20 Minutes or Earlier)

```bash
# Remove the deployment
helm uninstall simple-app

# Verify removal
kubectl get pods
```

## What's Running?

- **Application**: Simple Node.js HTTP server
- **Port**: 8080 (internal) → 80 (service) → 30080 (NodePort)
- **Duration**: 20 minutes (auto-shutdown)
- **Health Checks**: Liveness & Readiness probes enabled

## Troubleshooting

### Pod not starting?
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Can't access from browser?
```bash
# Check service
kubectl get svc simple-app
kubectl describe svc simple-app

# Test connectivity
kubectl run -it --rm debug --image=alpine --restart=Never -- wget -O- http://simple-app:80
```

### Port already in use?
Edit `examples/simple-web-app.yaml` and change `nodePort: 30080` to another port (30000-32767)

## Architecture

```
┌─────────────┐
│   Browser   │
│ :30080      │
└──────┬──────┘
       │
┌──────▼──────────────┐
│   NodePort Service  │
│   Port 80           │
└──────┬──────────────┘
       │
┌──────▼──────────────┐
│   Pod (Deployment)  │
│   :8080 (Node.js)   │
└─────────────────────┘
```

## Customization

See `examples/simple-web-app.yaml` for all available options:
- Change `replicaCount` for multiple instances
- Modify `resources.limits` for memory/CPU
- Adjust `nodePort` for different port
- Enable `autoscaling` for production

## References

- Helm Chart Documentation: See `README.md` in root
- Kubernetes NodePort Docs: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
- Pod lifecycle: Auto-shutdown after 20 minutes