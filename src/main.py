import uvicorn
from fastapi import FastAPI

from src.settings import settings

app = FastAPI()


@app.get("/")
def ping():
    return {"live": "ok"}


if __name__ == '__main__':
    uvicorn.run(
        "main:app",
        host=settings.API_HOST,
        port=settings.API_PORT,
        workers=settings.API_WORKERS,
    )
