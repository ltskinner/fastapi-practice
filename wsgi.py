import uvicorn

from webapp.application import app

from a2wsgi import ASGIMiddleware

application = ASGIMiddleware(app)


if __name__ == "__main__":
    # uvicorn webapp.application:app --host 0.0.0.0 --port 8000
    uvicorn.run(app, host="0.0.0.0", port=8000)
