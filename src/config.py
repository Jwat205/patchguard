# Application settings loaded from environment / .env
# TODO: define Settings class with pydantic-settings

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    # TODO: add all fields matching .env.example


settings = Settings()
