# Workout Share Format Specification

The official specification for representing workout programs in human-readable, machine-parseable YAML format.

## 🎯 Overview

Workout Share Format enables seamless sharing of workout programs between fitness apps, trainers, and enthusiasts through:
- **Standardized YAML format** for program representation
- **QR code sharing** for instant program transfer
- **Cross-app compatibility** for universal imports
- **Version control friendly** text-based storage

## 📁 Repository Contents

- **[Schema](schema/)** - JSON Schema for validation (the authoritative specification)
- **[Examples](examples/)** - Sample workout programs demonstrating features

## 🛠️ Development

This project uses [Taskfile.yml](Taskfile.yml) for common development tasks. Run `task --list` to see all available commands.

### Tools

The repository includes several Python tools in the `tools/` directory:

- `strip-comments.py`: Converts JSONC to JSON by removing comments
- `validator.py`: Validates YAML files against the schema
- `qr_generator.py`: Generates QR codes for workout programs

### Development Workflow

1. Install dependencies:
   ```bash
   uv sync
   ```

2. Make changes using conventional commits:
   ```bash
   task feat -- "add new feature"
   task fix -- "fix issue"
   task docs -- "update documentation"
   ```

3. For releases, use the `prepare-release` task which will:
   - Update the version
   - Regenerate the schema
   - Update the changelog

   ```bash
   task prepare-release
   ```

The changelog is automatically generated using [git-cliff](https://git-cliff.org/).

## 📖 Complete Specification

The **[workout-share-schema.jsonc](schema/workout-share-schema.jsonc)** file contains the complete, authoritative specification with:
- All field definitions and validation rules
- Pattern matching for time, weight, and rep formats
- Complete examples for every field type
- Detailed comments explaining usage
- Enum values for controlled vocabularies

For human-readable exploration, start with the [examples](examples/) and refer to the schema comments for detailed field specifications.

> **Note:** The `.jsonc` file is the source of truth. A JSON version is automatically generated using the `regenerate-schema` task.

## 🚀 Quick Start

### View Examples
- **[Basic](examples/basic/)** - Simple bodyweight and beginner programs
- **[Intermediate](examples/intermediate/)** - Dropsets, supersets, and splits
- **[Advanced](examples/advanced/)** - Multi-phase periodization programs

### Format Overview
```yaml
program_name: "My Workout Program"
frequency: "3 days per week"
duration: "8 weeks"

workouts:
  - name: "Upper Body"
    focus: "Push"
    exercises:
      - name: "Push-up"
        sets: 3
        reps: "8-12"
        rest: "60sec"
        notes: "Control the negative"
        substitutes: ["Incline push-up"]
```

### Validation
Use the [workout-share/tools](https://github.com/workout-share/tools) repository to validate your programs:

```bash
# Install validation tools
git clone https://github.com/workout-share/tools.git
cd tools

# Validate your program
uv run validator.py your-program.yaml

# Generate QR code for sharing
uv run qr_generator.py your-program.yaml
```

## 📖 Documentation

- **[Format Specification](docs/format-spec.md)** - Complete YAML format reference
- **[Implementation Guide](docs/implementation.md)** - Developer integration guide
- **[QR Code Standard](docs/qr-codes.md)** - Program sharing specification

## 🔗 Related Projects

- **[Tools](https://github.com/workout-share/tools)** - Python validator and QR generator
- **[Community](https://github.com/workout-share/community)** - User-contributed programs and templates

## 🌟 Key Features

### **Exercise Types**
- Standard exercises with sets, reps, weight, rest
- Dropsets with multiple weight drops
- Supersets with back-to-back exercises
- Circuit training with timed rounds

### **Advanced Programming**
- Multi-phase periodization (12+ week programs)
- Timing patterns (EMOM, circuits, intervals)
- Exercise variations by week
- Progressive overload tracking
- Equipment substitutions

### **Sharing & Integration**
- QR code generation for instant sharing
- JSON Schema validation for data integrity
- Human-readable format for easy editing
- Machine-parseable for app integration

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Ways to Contribute
- Add example programs to [examples/](examples/)
- Improve documentation in [docs/](docs/)
- Enhance the JSON schema in [schema/](schema/)
- Report issues or suggest format improvements

## 📄 License

Apache 2.0 License - see [LICENSE](LICENSE) for details.
Requires attribution when used or modified.

## 🏢 Organization

This repository is part of the [Workout Share](https://github.com/workout-share) organization, dedicated to creating open standards for fitness data exchange.

---

**Making workout program sharing as easy as scanning a QR code** 📱💪
