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
        host=settings.HOST,
        port=settings.PORT,
        workers=settings.WORKERS,
    )
