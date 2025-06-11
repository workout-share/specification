# Workout Share Format Specification

The official specification for representing workout programs in human-readable, machine-parseable YAML format.

## 🎯 Overview

Workout Share Format enables seamless sharing of workout programs between fitness apps, trainers, and enthusiasts through:
- **Standardized YAML format** for program representation
- **QR code sharing** for instant program transfer
- **Cross-app compatibility** for universal imports
- **Version control friendly** text-based storage

## 📁 Repository Contents

- **[Schema](schema/)** - JSON Schema for validation
- **[Examples](examples/)** - Sample workout programs demonstrating features
- **[Documentation](docs/)** - Complete format specification and guides

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