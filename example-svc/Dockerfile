FROM python:3.13-slim

WORKDIR /code

COPY ./pyproject.toml /code/pyproject.toml

RUN pip install --no-cache-dir --upgrade -e .

COPY . .

EXPOSE 9000

CMD ["fastapi", "run", "main.py", "--proxy-headers", "--port", "9000"]