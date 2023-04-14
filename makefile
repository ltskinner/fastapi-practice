
setup:
	python -m venv ~/.fastapi-jinja

source:
	. ~/.fastapi-jinja

install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

install-test:
	pip install -r requirements-test.txt

lint-force:
	isort .
	black .
	flake8 . --ignore=E501
	pylint --disable=R,C,pointless-string-statement ./*.py ./tests

lint-check:
	isort . --check-only
	black --check .
	flake8 . --ignore=E501
	pylint --disable=R,C,pointless-string-statement ./*.py ./tests

test-unit:
	coverage run -m pytest -vv ./tests
	coverage report -m

test-locust:
	locust -f tests/locustfile.py -H http://localhost -u 5 -r 1 -t 10 --headless

run-app:
	#uvicorn webapp.application:app --host 0.0.0.0 --port 8000
	python wsgi.py

docker-build:
	docker build -t ltskinner/fastapi-jinja2:latest .

docker-run-it-rm:
	docker run -it -p 80:8000 --rm ltskinner/fastapi-jinja2

docker-run-detach:
	# on everything holy
	# 80:8000 grabs an app running on 8000 forwards to container 80
	docker run -d --name faj2 -p 80:8000 ltskinner/fastapi-jinja2

docker-poll:
	docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}\t{{.Ports}}"

docker-stop:
	docker stop faj2

docker-push:
	docker push ltskinner/fastapi-jinja2:latest
