# Adding a New Service

To add a new service to the umbrella chart, follow these simple steps:

## 1. Copy the example service
```bash
cp -r charts/example-svc charts/your-service-name
```

The service templates automatically reference common templates from `templates/_common-*.tpl` in the root - no need to copy those!

## 2. Update Chart.yaml
Edit `charts/your-service-name/Chart.yaml` and change the name:
```yaml
name: your-service-name  # Change this line
description: Your service Helm chart
```

## 3. Add dependency to parent Chart.yaml
Edit `Chart.yaml` in the root and add your service:
```yaml
dependencies:
  - name: example-svc
    version: "0.1.0"
    repository: "file://./charts/example-svc"
    condition: example-svc.enabled
    tags:
      - services

  # Add your new service here
  - name: your-service-name
    version: "0.1.0"
    repository: "file://./charts/your-service-name"
    condition: your-service-name.enabled
    tags:
      - services
```

## 4. Add configuration to values.yaml
Edit `values.yaml` in the root and add your service config:
```yaml
your-service-name:
  enabled: true
  replicaCount: 1
  image:
    repository: your-service-name
    tag: "latest"
  service:
    type: NodePort
    port: 9001
    nodePort: 30089
  # Add your env vars, secrets, etc.
```

## 5. Build and install
```bash
helm dependency build
helm install my-release .
```

That's it! Each service uses the shared common templates from the root - single source of truth, no duplication!
