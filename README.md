# Local Helm Multi-Service Chart

This is an umbrella Helm chart for managing multiple services in a local Kubernetes environment.

## Structure

```
local-helm/
├── Chart.yaml              # Umbrella chart with dependencies
├── values.yaml            # Global configuration and service settings
├── templates/             # Shared common templates (single source of truth)
│   └── _common-*.tpl     # Reusable templates for all services
├── charts/                # Subcharts directory
│   └── example-svc/       # Individual service chart
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/     # Service templates (reference common templates)
│           ├── deployment.yaml
│           ├── service.yaml
│           └── secret.yaml
└── ADD_NEW_SERVICE.md     # Quick guide for adding services
```

## Setup

1. **Install prerequisites**: minikube, kubectl, and helm

2. **Build and load service images**:
   - The `example-svc/` folder contains an example FastAPI application
   - Follow the instructions in [example-svc/README.md](example-svc/README.md)
   - Load the image to minikube:
   ```shell
   minikube image load example-svc:latest
   ```

3. **Update dependencies**:
   ```shell
   helm dependency update .
   ```

4. **Install the charts**:

   Using the deployment script:
   ```shell
   ./deploy.sh
   ```

   Or using helm directly:
   ```shell
   helm upgrade --install local-helm --namespace dev .
   ```

## Managing Services

### Enable/Disable Services

Services can be enabled or disabled via the `values.yaml` file or command line:

```shell
# Disable a service
helm upgrade --install local-helm --namespace dev . --set example-svc.enabled=false

# Enable a service
helm upgrade --install local-helm --namespace dev . --set example-svc.enabled=true
```

### Override Service Configuration

Service-specific values can be overridden:

```shell
helm upgrade --install local-helm --namespace dev . \
  --set example-svc.replicaCount=3 \
  --set example-svc.image.tag=v2.0
```

## Adding New Services

**Simple 3-step process:**

1. **Copy the example service:**
   ```bash
   cp -r charts/example-svc charts/your-service-name
   ```

2. **Update the service name** in `charts/your-service-name/Chart.yaml`:
   ```yaml
   name: your-service-name  # Change this
   ```

3. **Add to parent Chart.yaml** and **values.yaml**:
   - Add dependency in root `Chart.yaml`
   - Add configuration in root `values.yaml`

See [ADD_NEW_SERVICE.md](ADD_NEW_SERVICE.md) for detailed instructions.

All services share common templates from `templates/_common-*.tpl` - no duplication needed!

