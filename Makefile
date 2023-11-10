.ONESHELL:

ENV_NAME=.venv
KERNAL_NAME = $(shell basename "$(CURDIR)")
PYTHON = ./$(ENV_NAME)/Scripts/python
PIP = ./$(ENV_NAME)/Scripts/pip

venv: requirements.txt
	python -m venv $(ENV_NAME)
	"$(PIP)" install -r requirements.txt

notebook-kernel: venv
	"$(PIP)" install -U jupyter ipykernel
	"$(PYTHON)" -m ipykernel install --user --name=$(KERNAL_NAME)

run: venv
	"$(PYTHON)" main.py

export-env: $(PYTHON)
	"$(PIP)" freeze >requirements.txt

clean:
	if exist "./$(ENV_NAME)" rd /s /q $(ENV_NAME)
	if exist "./__pycache__" rd /s /q __pycache__ 

.PHONY: run notebook-kernel clean