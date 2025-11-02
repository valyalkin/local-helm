# Example fastapi application

You need
1. docker
2. uv
3. python 3.13

Running the application

```shell
uv venv
source venv/bin/activate
uv sync
uv run fastapi main.py
```

Building container

```shell
docker build -t example-svc:latest .
```
