from fastapi import APIRouter
from fastapi.responses import ORJSONResponse

router = APIRouter()


@router.get("/status")
async def example():
    return ORJSONResponse({"status": "ok"}, status_code=200)
