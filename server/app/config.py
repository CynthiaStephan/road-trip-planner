from pathlib import Path

from pydantic_settings import BaseSettings, SettingsConfigDict

ROOT_ENV = Path(__file__).resolve().parents[2] / ".env"


class Settings(BaseSettings):
    environment: str = "development"

    database_user: str
    database_password: str
    database_name: str
    database_host: str
    database_port: int
    database_url: str

    map_key: str = ""

    cors_origins: list[str] = ["http://localhost:5173"]

    model_config = SettingsConfigDict(env_file=ROOT_ENV, extra="ignore")


settings = Settings()