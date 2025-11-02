# PostgreSQL Database

## Connection Information

### From Inside the Cluster (other services)
```
Host: test-release-postgresql.dev.svc.cluster.local
Port: 5432
Database: devdb
Username: devuser
Password: devpassword
```

Connection string:
```
postgresql://devuser:devpassword@test-release-postgresql:5432/devdb
```

### From Outside the Cluster (local machine)
```
Host: localhost (or minikube ip)
Port: 30432
Database: devdb
Username: devuser
Password: devpassword
```

Connect with psql:
```bash
# Get minikube IP
minikube ip

# Connect using psql
psql -h $(minikube ip) -p 30432 -U devuser -d devdb
# Password: devpassword
```

## Configuration

Database settings are in `values.yaml`:
```yaml
postgresql:
  enabled: true
  auth:
    username: devuser
    password: devpassword
    database: devdb
  primary:
    service:
      type: NodePort
      nodePorts:
        postgresql: 30432
    persistence:
      enabled: true
      size: 8Gi  # Data persists across pod restarts
```

## Connecting Your Services to PostgreSQL

To connect `example-svc` to PostgreSQL, add environment variables:

```yaml
example-svc:
  env:
    - name: DATABASE_URL
      value: "postgresql://devuser:devpassword@test-release-postgresql:5432/devdb"
    # Or use individual variables
    - name: DB_HOST
      value: "test-release-postgresql"
    - name: DB_PORT
      value: "5432"
    - name: DB_NAME
      value: "devdb"
    - name: DB_USER
      value: "devuser"
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: test-release-postgresql
          key: password
```

## Persistence

**Persistence is enabled by default** - your data will survive pod restarts and redeployments.

The PostgreSQL data is stored in a PersistentVolumeClaim (PVC) of 8Gi.

To change the size:
```yaml
postgresql:
  primary:
    persistence:
      size: 16Gi  # Change to desired size
```

To disable persistence (not recommended):
```yaml
postgresql:
  primary:
    persistence:
      enabled: false
```

## Disable PostgreSQL

To disable the database:

```yaml
postgresql:
  enabled: false
```

Or via command line:
```bash
helm upgrade --install local-helm . --set postgresql.enabled=false
```

## To temporarily connect locally enable port forwarding 


```shell
kubectl port-forward -n dev svc/local-helm-postgresql 5432:5432
```