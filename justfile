# Shared Python CI commands. Set --working-directory to the caller repository.
python := env("PYTHON", "python3")

# List the available commands.
default:
    @just --justfile "{{justfile()}}" --list

# Create the virtual environment and install development dependencies.
install:
    "{{python}}" -m venv .venv
    .venv/bin/python -m pip install -r requirements-dev.txt

# Check Python code with Ruff.
lint:
    .venv/bin/python -m ruff check .

# Run tests and save a JUnit report, including test failures.
test:
    .venv/bin/python -m pytest -q --junitxml=reports/junit.xml

# Run the local CI checks in order. Run the install recipe first.
ci: lint test
