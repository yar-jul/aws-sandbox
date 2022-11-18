import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from settings import settings

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://api-test-v1.yarjul.com",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def ping():
    return {"health": "ok"}


@app.get("/hello")
def hello():
    return {"message": "Hello World!"}


if __name__ == '__main__':
    uvicorn.run(
        "main:app",
        host=settings.API_HOST,
        port=settings.API_PORT,
        workers=settings.API_WORKERS,
    )
