from pydantic import BaseSettings


class Settings(BaseSettings):
    API_HOST: str
    API_PORT: int
    API_WORKERS: int


settings = Settings()
