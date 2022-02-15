from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

from application.api.v1 import api_router
from application.settings import AppSettings, get_settings


def create_app(settings: AppSettings = get_settings()) -> FastAPI:
    app = FastAPI(debug=settings.DEBUG, title=settings.APPLICATION_NAME)
    root_path = settings.APPLICATION_NAME

    app.include_router(api_router, prefix=f"/{root_path}/v1")

    # Set all CORS enabled origins
    if settings.BACKEND_CORS_ORIGINS:
        app.add_middleware(
            CORSMiddleware,
            allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
            allow_credentials=True,
            allow_methods=["*"],
            allow_headers=["*"],
        )

    return app
