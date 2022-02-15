.PHONY: setup \
		run \
		test \

virtual_env:
	python -m venv ve

setup: virtual_env
	. ve/bin/activate; pip install wheel setuptools
	. ve/bin/activate; pip install --no-cache --exists-action w -Ur requirements/dev.txt
	. ve/bin/activate; pre-commit install

setup_prod: virtual_env
	. ve/bin/activate; pip install wheel setuptools
	. ve/bin/activate; pip install --no-cache --exists-action w -Ur requirements/production.txt

run:
	. ve/bin/activate; uvicorn main:app --port ${PORT} --host ${HOST}

run_prod:
	. ve/bin/activate; gunicorn main:app --workers ${WORKERS} --worker-class uvicorn.workers.UvicornWorker --bind ${HOST}:${PORT}

test:
	. ve/bin/activate; python -m pytest -v

coverage:
	. ve/bin/activate; python -m pytest -vv --cov=application tests/ --no-cov-on-fail --tb=no tests/

lint:
	. ve/bin/activate; flake8

mypy:
	. ve/bin/activate; mypy ./application

black:
	. ve/bin/activate; isort .; black .

clean:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
	rm -f .coverage
	rm -fr htmlcov/
