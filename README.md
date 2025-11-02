# Running kubernetes setup locally

1. Install minikibe, kubectl and helm

example-svc folder contains example fastapi application, follow the [example-svc/README.md](example)
and push docker image to local repository.

2. Load the image to minikube's docker

```shell
minikube image load example-svc:latest
```

3. Install charts using deployment script

```shell
./deploy.sh
```

or a command line

```shell
helm upgrade --install local-helm --namespace dev .
```

This installs charts to dev namespace

