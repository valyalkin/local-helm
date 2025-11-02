from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/readiness")
async def health():
    return {"status": "ok"}

@app.get("/liveness")
async def health():
    return {"status": "ok"}
