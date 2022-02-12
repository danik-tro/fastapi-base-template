from pydantic import BaseSettings


class AppSettings(BaseSettings):
    DEBUG: bool = False
    BACKEND_CORS_ORIGINS: list[str] | None
    APPLICATION_NAME: str


def get_settings(**overload_settings):
    return AppSettings(**overload_settings)
