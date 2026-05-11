# FastAPI application entry point
# TODO: create app, register routers (api/webhooks, api/reviews, api/health), add startup/shutdown events

from fastapi import FastAPI

app = FastAPI(title="PatchGuard", version="0.1.0")
