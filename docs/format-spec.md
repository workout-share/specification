# Workout Program YAML Format Specification

## Overview

The Workout Program YAML Standard defines a human-readable, software-parseable format for representing complex fitness programs. This specification covers all supported fields, data types, and structural patterns.

## Core Structure

### Program Metadata
```yaml
program_name: "String"          # Required: Program title
description: "String"           # Optional: Program description  
frequency: "String"             # Optional: Training frequency
duration: "String"              # Optional: Total program duration
author: "String"                # Optional: Program creator
version: "String"               # Optional: Program version
```

### Basic Program Structure
```yaml
workouts:                       # Required: List of workout sessions
  - name: "String"              # Required: Workout name
    focus: "String"             # Optional: Workout focus/theme
    exercises: []               # Required: List of exercises

phases:                         # Optional: Multi-phase programming
  - name: "String"              # Required: Phase name
    weeks: Integer              # Required: Phase duration
    workouts: []                # Required: Workouts for this phase
```

**Note:** All programs must have `workouts` (the core training sessions). `phases` are optional and used for complex periodized programs to show progression over time.

## Exercise Definition

### Basic Exercise
```yaml
- name: "String"                # Required: Exercise name
  sets: Integer                 # Required: Number of sets
  reps: Integer|String          # Required: Repetitions (can be range like "8-12")
  weight: String|Number         # Optional: Weight/resistance
  rest: String                  # Optional: Rest period
  notes: "String"               # Optional: Form cues, instructions
  substitutes: []               # Optional: Alternative exercises
```

### Advanced Exercise Types

#### Dropset
```yaml
- name: "Exercise Name"
  type: dropset
  sets: Integer
  reps: "to failure"|Integer
  drops:
    - weight: String|Number
      reps: "to failure"|Integer
    - weight: String|Number
      reps: "to failure"|Integer
```

#### Superset
```yaml
- type: superset
  sets: Integer
  rest_between_rounds: String
  exercises:
    - name: "Exercise 1"
      reps: Integer
      weight: String|Number
    - name: "Exercise 2" 
      reps: Integer
      weight: String|Number
```

#### Circuit Training
```yaml
- type: circuit
  rounds: Integer
  rest_between_exercises: Integer
  rest_between_rounds: Integer
  exercises:
    - name: "Exercise 1"
      duration: Integer           # In seconds
    - name: "Exercise 2"
      reps: Integer
```

## Advanced Features

### Multi-Phase Programs
```yaml
phases:
  - name: "Phase 1"
    weeks: Integer
    description: "String"
    workouts: []
  - name: "Phase 2"
    weeks: Integer  
    description: "String"
    workouts: []
```

### Timing Patterns
```yaml
timing:
  pattern: "EMOM"|"every_X_minutes"|"every_X_seconds"|"circuit"
  interval: Integer             # Minutes or seconds based on pattern
  duration: Integer             # Total duration in minutes
  notes: "String"               # Additional timing instructions
```

### Exercise Variations
```yaml
variations:
  week_2:
    name: "Modified Exercise Name"
    reps: Integer|String
    notes: "String"
  week_3:
    name: "Different Exercise Name"
    reps: Integer|String
```

### Workout Sections
```yaml
sections:
  - category: "Warm Up"|"Strength & Condition"|"Accessories"
    exercises: []
```

### Special Techniques
```yaml
special_technique:
  week_2: "1 & ¼ reps. Go all the way down, ¼ of the way up, all the way down, all the way up"
  week_3: "Cluster sets: failure, 10s rest, failure again"
```

## Program Metadata

### Progression Tracking
```yaml
progression:
  type: "linear"|"percentage"|"phase_based"
  increment: String|Number
  deload:
    frequency: Integer          # Weeks between deloads
    percentage: Integer         # Percentage of normal load
```

### Equipment Requirements
```yaml
equipment_needed:
  primary: []                   # Essential equipment
  optional: []                  # Nice-to-have equipment
```

### Special Techniques Documentation
```yaml
special_techniques:
  - name: "Technique Name"
    description: "String"
    used_in: []                 # Where technique appears
```

## Data Types

### Repetitions
- `Integer`: Fixed number (1-100)
- `String`: Must match pattern:
  - Range: `"8-12"`, `"5-8"`
  - Each side: `"10 e/s"`, `"5 e/s"`  
  - Duration: `"30sec"`, `"2min"`
  - Special: `"to failure"`, `"max reps"`

### Weight/Resistance  
- `Number`: Specific weight (0 or positive)
- `String`: Must match pattern:
  - With units: `"80kg"`, `"25lbs"`, `"15.5kg"`
  - Descriptive: `"bodyweight"`, `"BW"`, `"light"`, `"moderate"`, `"heavy"`

### Rest Periods
- `String`: Must match pattern:
  - Fixed: `"60sec"`, `"2min"`, `"90s"`
  - Range: `"30-60sec"`, `"1-2min"`
  - None: `"0s"` or `"0"`

### Duration (for timed exercises)
- `Integer`: Seconds (1 or more)
- `String`: Must match pattern:
  - Time: `"30sec"`, `"2min"`, `"45s"`
  - Each side: `"30 e/s"`

### Frequency
- Must match pattern: `"X days per week"`, `"daily"`, `"every other day"`
- Examples: `"3 days per week"`, `"5 days per week"`

## Validation Rules

1. **Required Fields**: `program_name`, `workouts`, exercise `name`, `sets`, `reps`
2. **Optional Phases**: `phases` can be included for complex periodized programs
3. **Exercise Types**: Must specify either individual exercise OR exercise type (dropset, superset, circuit)
4. **Timing Patterns**: When specified, must include valid `pattern` and appropriate `interval`
5. **Phase Structure**: If using phases, each phase must contain `workouts`
6. **Substitutes**: Must be array of strings (max 5 items)
7. **Equipment**: Must use predefined equipment enum values
8. **Patterns**: All time/weight/rep values must match specified regex patterns
9. **Limits**: Sets (1-20), Reps (1-100), Rounds (1-20), Equipment items (max 5)

## Pattern Validation

### Time Patterns
- Rest: `^(\d+sec|\d+min|\d+-\d+sec|\d+-\d+min|0s?)$`
- Duration: `^\d+\s*(sec|min|s)$|\d+\s+e/s$`

### Exercise Patterns  
- Reps: `^(\d+-\d+|\d+\s+e/s|to failure|\d+sec|\d+min|max reps)$`
- Weight: `^\d+(\.\d+)?\s*(kg|lbs|g)?|bodyweight|BW|light|moderate|heavy$`

### Program Patterns
- Frequency: `^[1-7] days? per week$|^daily$|^every other day$`
- Duration: `^\d+\s+(days?|weeks?|months?).*$`
- Version: `^\d+\.\d+\.\d+$`

## Enums and Controlled Values

### Workout Focus
`"Full Body"`, `"Upper Body"`, `"Lower Body"`, `"Push"`, `"Pull"`, `"Legs"`, `"Chest"`, `"Back"`, `"Shoulders"`, `"Arms"`, `"Core"`, `"Cardio"`, `"Strength"`, `"Hypertrophy"`, `"Endurance"`, `"Power"`, `"Mobility"`

### Section Categories  
`"Warm Up"`, `"Strength & Condition"`, `"Hypertrophy Focus"`, `"Swole & Flexy"`, `"Accessories"`, `"Cool Down"`, `"Cardio"`, `"Mobility"`, `"Core"`, `"Power"`, `"Conditioning"`

### Timing Patterns
`"EMOM"`, `"every_X_minutes"`, `"every_X_seconds"`, `"circuit"`, `"rest_pause"`

### Progression Types
`"linear"`, `"percentage"`, `"phase_based"`, `"autoregulation"`, `"wave"`

### Equipment (Primary)
`"Barbell"`, `"Dumbbells"`, `"Kettlebell"`, `"Pull-up bar"`, `"Bench"`, `"Cable machine"`, `"Resistance bands"`, `"None - bodyweight only"`, `"Leg press"`, `"Smith machine"`, `"TRX"`, `"Gymnastic rings"`, `"Medicine ball"`, `"Foam roller"`, `"Yoga mat"`

## Best Practices

1. **Naming**: Use clear, descriptive exercise names
2. **Notes**: Include form cues and safety reminders
3. **Substitutes**: Always provide alternatives for different equipment levels
4. **Progression**: Include clear progression guidelines
5. **Units**: Be explicit about weight units and time measurements
6. **Validation**: Test YAML syntax before sharing

## Examples

See the `examples/` directory for complete program implementations:
- `basic/`: Simple programs demonstrating core features
- `intermediate/`: Programs with advanced exercise types
- `advanced/`: Complex multi-phase programs with all features
