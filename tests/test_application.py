from fastapi.testclient import TestClient

from webapp.application import app

client = TestClient(app)


def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert "<h3>/</h3>" in response.text
    assert "<h3>/items/{INT}</h3>" in response.text


def test_read_item_fail():
    response = client.get("/items")
    assert response.status_code == 404


def test_read_item_pass():
    value = 9
    response = client.get(f"/items/{value}")
    assert response.status_code == 200
    assert f"<h1>Item ID: {value}</h1>" in response.text
