#!/usr/bin/env python3
"""
Workout Share Format Validator

Validates YAML workout files against the JSON Schema specification.
"""

import json
import sys
import os
from pathlib import Path
import yaml
import jsonschema


def load_schema(schema_path: str) -> dict:
    """Load JSON Schema from file."""
    try:
        with open(schema_path) as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"❌ Schema file not found: {schema_path}")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON in schema: {e}")
        sys.exit(1)


def load_workout(workout_path: str) -> dict:
    """Load workout YAML file."""
    try:
        with open(workout_path) as f:
            return yaml.safe_load(f)
    except FileNotFoundError:
        print(f"❌ Workout file not found: {workout_path}")
        sys.exit(1)
    except yaml.YAMLError as e:
        print(f"❌ Invalid YAML in workout: {e}")
        sys.exit(1)


def validate_workout(workout_data: dict, schema: dict, filepath: str) -> bool:
    """Validate workout data against schema."""
    try:
        jsonschema.validate(workout_data, schema)
        return True
    except jsonschema.ValidationError as e:
        print(f"❌ Validation error in {filepath}:")
        print(f"   {e.message}")
        if e.path:
            print(f"   At: {' -> '.join(str(p) for p in e.path)}")
        return False
    except jsonschema.SchemaError as e:
        print(f"❌ Schema error: {e}")
        return False


def validate_file(workout_path: str, schema_path: str) -> bool:
    """Validate a single workout file."""
    print(f"Validating {workout_path}...")

    schema = load_schema(schema_path)
    workout = load_workout(workout_path)

    if validate_workout(workout, schema, workout_path):
        print(f"✅ {workout_path} is valid")
        return True
    else:
        return False


def validate_directory(directory: str, schema_path: str) -> bool:
    """Validate all YAML files in a directory."""
    print(f"Validating all YAML files in {directory}...")

    schema = load_schema(schema_path)
    errors = 0
    total = 0

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.yaml') or file.endswith('.yml'):
                filepath = os.path.join(root, file)
                total += 1
                print(f"  {filepath}...")

                try:
                    workout = load_workout(filepath)
                    if validate_workout(workout, schema, filepath):
                        print(f"    ✅ Valid")
                    else:
                        errors += 1
                except Exception as e:
                    print(f"    ❌ Error: {e}")
                    errors += 1

    if errors == 0:
        print(f"🎉 All {total} files passed validation!")
        return True
    else:
        print(f"❌ {errors} of {total} files failed validation")
        return False


def main():
    """Main entry point."""
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python3 validate.py <workout-file.yaml>")
        print("  python3 validate.py <directory>")
        print("")
        print("Schema is automatically loaded from ../schema/workout-share-schema.json")
        sys.exit(1)

    target = sys.argv[1]

    # Find schema file relative to this script
    script_dir = Path(__file__).parent
    schema_path = script_dir.parent / "schema" / "workout-share-schema.json"

    if not schema_path.exists():
        print(f"❌ Schema not found at {schema_path}")
        print("Run 'task regenerate-schema' first")
        sys.exit(1)

    # Validate file or directory
    if os.path.isfile(target):
        success = validate_file(target, str(schema_path))
    elif os.path.isdir(target):
        success = validate_directory(target, str(schema_path))
    else:
        print(f"❌ Path not found: {target}")
        sys.exit(1)

    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
