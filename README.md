# Common Helm Chart - Production Ready

A comprehensive, fully-featured Helm chart template for Kubernetes applications supporting all major workload types and production features.

## Features

✅ **Workload Types**
- Deployment
- StatefulSet
- DaemonSet (ready)
- Job (ready)
- CronJob (ready)

✅ **Networking**
- Service (ClusterIP, NodePort, LoadBalancer, ExternalName)
- Ingress with TLS support
- NetworkPolicy for security

✅ **Storage**
- PersistentVolumeClaim
- ConfigMap
- Secret management
- EmptyDir volumes

✅ **Security**
- ServiceAccount and RBAC
- Pod Security Policy
- Security Context
- Network Policies

✅ **Observability**
- Liveness, Readiness, Startup Probes
- Pod annotations for monitoring
- Checksum for configuration changes

✅ **Scalability**
- Horizontal Pod Autoscaler (HPA)
- Pod Disruption Budget (PDB)
- Resource limits and requests

✅ **Advanced Features**
- Init Containers
- Lifecycle hooks
- DNS configuration
- Host settings
- Affinity rules
- Tolerations
- Priority classes

## Installation

```bash
helm install my-release ./ -f values.yaml
```

## Configuration

See `values.yaml` for all available configuration options.

### Basic Deployment

```bash
helm install my-app ./ \
  --set image.repository=myapp \
  --set image.tag=1.0.0 \
  --set service.enabled=true \
  --set ingress.enabled=true
```

### With Custom Namespace

```bash
helm install my-app ./ \
  --set namespace.create=true \
  --set namespace.name=production
```

### With StatefulSet

```bash
helm install my-database ./ \
  --set workload.type=StatefulSet \
  --set replicaCount=3 \
  --set persistence.enabled=true \
  --set persistence.size=50Gi
```

## Directory Structure

```
.
├── Chart.yaml                 # Chart metadata
├── values.yaml               # Default configuration values
├── README.md                 # This file
└── templates/
    ├── _helpers.tpl          # Template helpers
    ├── namespace.yaml        # Namespace resource
    ├── service.yaml          # Service resource
    ├── ingress.yaml          # Ingress resource
    ├── deployment.yaml       # Deployment resource
    ├── statefulset.yaml      # StatefulSet resource
    ├── configmap.yaml        # ConfigMap resource
    ├── secret.yaml           # Secret resource
    ├── serviceaccount.yaml   # ServiceAccount resource
    ├── clusterrole.yaml      # ClusterRole resource
    ├── clusterrolebinding.yaml # ClusterRoleBinding resource
    ├── role.yaml             # Role resource
    ├── rolebinding.yaml      # RoleBinding resource
    ├── hpa.yaml              # HorizontalPodAutoscaler resource
    ├── pdb.yaml              # PodDisruptionBudget resource
    ├── networkpolicy.yaml    # NetworkPolicy resource
    ├── persistentvolumeclaim.yaml # PersistentVolumeClaim resource
    └── podsecuritypolicy.yaml # PodSecurityPolicy resource
```

## Template Helpers

The `_helpers.tpl` file provides common template functions:

- `common-helm-chart.name` - Chart name
- `common-helm-chart.fullname` - Full release name
- `common-helm-chart.chart` - Chart reference
- `common-helm-chart.labels` - Standard labels
- `common-helm-chart.selectorLabels` - Selector labels
- `common-helm-chart.serviceAccountName` - Service account name

## Best Practices

1. **Always specify resource limits**
   ```yaml
   resources:
     requests:
       cpu: 100m
       memory: 128Mi
     limits:
       cpu: 500m
       memory: 512Mi
   ```

2. **Use health checks**
   ```yaml
   livenessProbe:
     httpGet:
       path: /health
       port: 8080
     initialDelaySeconds: 30
   ```

3. **Enable NetworkPolicy for security**
   ```yaml
   networkPolicy:
     enabled: true
   ```

4. **Use Pod Security Policy**
   ```yaml
   podSecurityPolicy:
     enabled: true
   ```

5. **Enable autoscaling for production**
   ```yaml
   autoscaling:
     enabled: true
     minReplicas: 2
     maxReplicas: 10
   ```

## Examples

### Example 1: Web Application

```yaml
workload:
  type: Deployment
replicaCount: 3
image:
  repository: myapp
  tag: 1.0.0
service:
  type: ClusterIP
  ports:
    - name: http
      port: 80
      targetPort: 8080
ingress:
  enabled: true
  hosts:
    - host: myapp.example.com
      paths:
        - path: /
          pathType: Prefix
autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
```

### Example 2: Database StatefulSet

```yaml
workload:
  type: StatefulSet
replicaCount: 3
image:
  repository: postgres
  tag: 13
service:
  type: ClusterIP
  ports:
    - name: postgres
      port: 5432
      targetPort: 5432
persistence:
  enabled: true
  size: 50Gi
  storageClassName: fast-ssd
```

### Example 3: Microservice with RBAC

```yaml
workload:
  type: Deployment
serviceAccount:
  create: true
rbac:
  create: true
  rules:
    - apiGroups: [""]
      resources: ["configmaps"]
      verbs: ["get", "list", "watch"]
networkPolicy:
  enabled: true
podSecurityPolicy:
  enabled: true
```

## Troubleshooting

### Check chart syntax
```bash
helm lint ./
```

### Dry run to see what will be deployed
```bash
helm install my-app ./ --dry-run --debug
```

### View rendered templates
```bash
helm template my-app ./
```

### Validate against Kubernetes API
```bash
helm install my-app ./ --dry-run --validate
```

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/omprakashsurwase-er/common-helm-chart).

## License

This chart is available under the Apache 2.0 License.
