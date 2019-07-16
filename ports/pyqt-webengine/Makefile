
install:
	pip3 install -r requirements.txt

install-dev: install
	pip3 install -r dev-requirements.txt

run:
	python3 next-pyqt.py

build-webengine:
	pyinstaller next-pyqt.py

isort:
	# sort imports, one per line.
	isort -y --atomic

qa:
	flake8 *.py
