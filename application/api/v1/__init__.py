from fastapi import APIRouter

from application.api.v1.endpoints import example

api_router = APIRouter()
api_router.include_router(example.router, prefix="/example", tags=["example"])
