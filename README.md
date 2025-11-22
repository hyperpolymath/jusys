# Juisys - Julia System Optimizer

**Privacy-First, GDPR-Compliant Application Auditing Tool**

Juisys is an educational tool that audits installed applications, classifies them by privacy/cost risks, and suggests FOSS (Free and Open Source Software) alternatives. Built from comprehensive specifications covering GDPR principles, Hazard Triangle methodology, and Calm Technology.

---

## Key Features

✅ **100% Local Processing** - No network calls, no telemetry, complete privacy
✅ **GDPR Compliant** - Demonstrates all 12 GDPR processing types with explicit consent
✅ **Hazard Triangle** - ELIMINATE → SUBSTITUTE → CONTROL risk management
✅ **Multi-Modal Interface** - CLI, GUI, ambient computing (visual/audio/IoT)
✅ **Cross-Platform** - Windows (winget), Linux (apt/dnf/pacman/zypper), macOS (brew)
✅ **Self-Auditing** - Tool audits its own code for privacy compliance
✅ **Educational** - Demonstrates real-world GDPR implementation

### Optional: Technical Diagnostics Add-on

🔧 **Developer-Focused Extension** (optional, requires D compiler)
- Comprehensive system diagnostics (hardware, software, network)
- Similar to SIW (System Information for Windows) but for macOS/Linux
- Written in D for performance, integrated with Julia core
- Same privacy guarantees (local only, ephemeral, consent-based)
- 4 diagnostic levels: BASIC, STANDARD, DEEP, FORENSIC
- See [docs/diagnostics/DIAGNOSTICS.md](docs/diagnostics/DIAGNOSTICS.md)

---

## Quick Start

### Installation

```bash
# Clone repository
git clone https://github.com/your-org/jusys.git
cd jusys

# Install Julia (1.6+) from https://julialang.org/downloads/

# Install dependencies
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

### Running Juisys

**NO PEEK Mode** (Maximum Privacy - No System Access):
```bash
julia --project=. -e 'include("src/cli.jl"); CLI.run_no_peek_mode()'
```

**Full Audit** (Requires Consent):
```bash
julia --project=. -e 'include("src/cli.jl"); CLI.run()'
# Select option 3 from menu
```

**Self-Audit** (Check Privacy Compliance):
```bash
julia --project=. -e 'include("src/security.jl"); using .Security; println(Security.get_privacy_report())'
```

---

## Operating Modes

### 1. NO PEEK Mode 🔒
**Maximum privacy** - Manual app entry only, zero system access, no consent required.
Perfect for sensitive environments or when you want absolute privacy control.

### 2. Quick Scan ⚡
Fast package manager scan with basic classification and alternative suggestions.

### 3. FULL AUDIT 🔍
Comprehensive analysis with:
- Risk classification
- Privacy scoring
- FOSS alternatives
- Cost savings analysis
- Detailed recommendations
- Multi-format reports

### 4. Import Mode 📥
Load app lists from files (CSV, JSON, TXT) for offline/air-gapped systems.

### 5. Export Mode 📤
Generate reports in multiple formats:
- Markdown (human-readable)
- XLSX (spreadsheet analysis)
- CSV (data export)
- JSON (machine-readable)
- HTML (web viewing)

### 6. Self-Audit Mode 🛡️
**Transparency feature** - Juisys audits its own code for privacy compliance:
- Scans for network calls
- Verifies ephemeral storage
- Checks consent framework
- Validates data minimization

### 7. GUI Mode 🖥️
Optional graphical interface with color-coded risk visualization (requires GTK.jl).

### 8. Ambient Mode 🎨
Multi-modal feedback following Calm Technology principles:
- **Visual**: Color-coded terminal output
- **Audio**: Proportional beeps for warnings
- **IoT**: MQTT notifications to smart home devices

---

## Privacy Architecture

### Core Principles

1. **NO Network Calls** - 100% local processing (GDPR Article 5.1.f)
2. **Ephemeral Data** - All data cleared after session (GDPR Article 5.1.e)
3. **Explicit Consent** - Permission required for system access (GDPR Article 6.1.a)
4. **Self-Auditing** - Tool verifies its own privacy compliance

### Hazard Triangle Implementation

Following OSHA safety hierarchy of controls:

- **ELIMINATE**: NO PEEK mode (manual entry, zero risk)
- **SUBSTITUTE**: Local JSON database (no API calls)
- **CONTROL**: Consent checks + ephemeral storage

### GDPR Processing Types Demonstrated

Juisys implements all 12 GDPR processing types:

1. **Collection** - User input, file import, system scanning
2. **Recording** - Temporary in-memory storage
3. **Organization** - Categorization and structuring
4. **Structuring** - Classification taxonomy
5. **Storage** - Ephemeral session storage only
6. **Adaptation** - Risk scoring algorithms
7. **Retrieval** - Database lookups
8. **Consultation** - User queries
9. **Use** - Analysis and reporting
10. **Disclosure** - Report exports (with consent)
11. **Dissemination** - File writing (with consent)
12. **Erasure** - Session cleanup (automatic)

---

## Project Structure

```
jusys/
├── CLAUDE.md              # AI assistant context
├── README.md              # This file
├── TUTORIAL.md            # Step-by-step user guide
├── ETHICS.md              # GDPR deep-dive
├── CONTRIBUTING.md        # Contribution guidelines
├── PROJECT_SUMMARY.md     # Technical overview
├── LICENSE                # MIT License
├── Project.toml           # Julia package config
├── .gitignore             # Git ignore patterns
├── .gitlab-ci.yml         # CI/CD pipeline
├── src/                   # Source code
│   ├── core.jl            # Classification engine
│   ├── security.jl        # GDPR & consent
│   ├── io.jl              # Input/output handling
│   ├── cli.jl             # Command-line interface
│   ├── gui.jl             # Graphical interface
│   ├── reports.jl         # Report generation
│   ├── alternatives.jl    # FOSS suggestions
│   ├── automate.jl        # System scanning
│   └── ambient.jl         # Ambient computing
├── test/                  # Test suite
├── data/                  # Databases
│   ├── app_db.json        # App alternatives (8+ entries)
│   └── rules.json         # Classification rules
├── examples/              # Usage examples
├── benchmarks/            # Performance tests
├── docker/                # Docker support
└── docs/                  # Documentation
```

---

## Documentation

- **[TUTORIAL.md](TUTORIAL.md)** - Start here! Step-by-step usage guide
- **[ETHICS.md](ETHICS.md)** - GDPR principles and privacy details
- **[PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)** - Complete technical overview
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Development and contribution guide
- **[CLAUDE.md](CLAUDE.md)** - Context for AI assistants

---

## Example: Finding Alternatives

```julia
# Load modules
include("src/alternatives.jl")
using .Alternatives

# Find FOSS alternatives
db_path = "data/app_db.json"
alternatives = find_alternatives("Adobe Photoshop", db_path)

# Calculate savings
proprietary_cost = 239.88
(savings, best) = calculate_savings(proprietary_cost, alternatives)

println("Potential savings: \$$savings/year")
println("Best alternative: $(best.name)")
```

---

## Educational Value

Juisys demonstrates:

1. **GDPR Compliance** - Real-world implementation of all 12 processing types
2. **Privacy-First Design** - Architecture that prioritizes user privacy
3. **Hazard Triangle** - Risk management methodology from safety engineering
4. **Calm Technology** - Multi-modal, glanceable, proportional feedback
5. **Consent Management** - Explicit, granular, revocable permissions
6. **Data Minimization** - Collect only what's necessary
7. **Transparency** - Self-auditing capabilities

---

## Testing

```bash
# Run all tests
julia --project=. test/runtests.jl

# Run privacy validation tests (critical!)
julia --project=. -e 'include("test/test_privacy.jl")'

# Run with coverage
julia --project=. --code-coverage=user test/runtests.jl
```

---

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for:

- Code style guidelines
- Testing requirements
- Privacy compliance checks
- Pull request process

**Important**: All code must pass privacy validation tests.

---

## Requirements

### Required
- Julia 1.6+
- JSON3.jl

### Optional (Graceful Degradation)
- GTK.jl (graphical interface)
- XLSX.jl (Excel reports)
- HTTP.jl (web dashboard)
- MQTT.jl (IoT notifications)

---

## Supported Package Managers

- **Windows**: winget
- **Debian/Ubuntu**: apt
- **Fedora/RHEL**: dnf
- **Arch Linux**: pacman
- **openSUSE**: zypper
- **macOS/Linux**: Homebrew

NO PEEK mode works on all systems without package manager.

---

## License

MIT License - See [LICENSE](LICENSE) file

---

## Attribution

Built with Claude Sonnet 4.5 (Anthropic) as an educational demonstration of:
- GDPR compliance in practice
- Privacy-first software design
- Calm Technology principles
- Open source philosophy

See [ETHICS.md](ETHICS.md) for detailed attribution and development context.

---

## FAQ

**Q: Does Juisys send any data over the network?**
A: No. 100% local processing. Self-audit verifies this.

**Q: Is my data stored anywhere?**
A: No. All data is ephemeral (in-memory only) and cleared after session.

**Q: Do I need to grant system access?**
A: No. NO PEEK mode requires zero permissions. Other modes request explicit consent.

**Q: Can I trust the privacy claims?**
A: Yes. Run the self-audit (Mode 6) to verify. All source code is open for inspection.

**Q: What if my package manager isn't supported?**
A: Use NO PEEK mode (manual entry) or Import mode (load from file).

**Q: How accurate are the FOSS alternatives?**
A: Database contains curated alternatives with feature parity scores. Expand it by editing `data/app_db.json`.

---

## Support

For questions, issues, or contributions:
- File an issue on GitHub
- See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup
- Check [TUTORIAL.md](TUTORIAL.md) for usage examples

---

**Remember**: Juisys is an educational tool demonstrating GDPR principles through a functional product. Review the code, learn from it, and build privacy-respecting software!
