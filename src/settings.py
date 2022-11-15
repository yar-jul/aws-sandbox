from pydantic import BaseSettings


class Settings(BaseSettings):
    HOST: str
    PORT: int
    WORKERS: int


settings = Settings()
