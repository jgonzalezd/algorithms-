# Algorithm Study Environment

VS Code devcontainer with **Ruby**, **Python**, **JavaScript**, and **TypeScript** for algorithm study.

## 🚀 Quick Start

### Option 1: All Languages (Default)
```bash
cd .devcontainer
./build.sh
```

### Option 2: Custom Stack
```bash
cd .devcontainer
./build.sh --node-only                    # Just Node.js
./build.sh --ruby --python               # Ruby + Python
./build.sh --python-only --with-postgres # Python + PostgreSQL
./build.sh --help                        # See all options
```

### Option 3: VS Code Devcontainer
1. **Open in devcontainer** (VS Code will prompt)
2. **Start coding** in category directories

## 🐛 Debugging

**Full debugging support for all 4 languages!**

1. **Open any algorithm file** (`.rb`, `.py`, `.js`, `.ts`)
2. **Set breakpoints** in gutter
3. **Press F5** to debug
4. **Select language-specific configuration**

```bash
# Debug examples
ruby sorting/bubble_sort/bubble_sort_debug.rb
python sorting/bubble_sort/bubble_sort_debug.py
node sorting/bubble_sort/bubble_sort_debug.js
ts-node sorting/bubble_sort/bubble_sort_debug.ts
```

## 📁 Project Structure

```
{category}/{algorithm}/[{ruby impl}|{python impl}|{js impl}|{ts impl}]

Example:
sorting/bubble_sort/
├── bubble_sort.rb      # Ruby
├── bubble_sort.py      # Python  
├── bubble_sort.js      # JavaScript
├── bubble_sort.ts      # TypeScript
├── README.md           # Documentation
└── test_cases.json     # Test cases
```

## 🔧 Languages & Tools

| Language | Version | Manager | Debug | Build Flag |
|----------|---------|---------|-------|------------|
| **Ruby** | 3.2.0 | RVM | ✅ | `--ruby` |
| **Python** | 3.11.0 | apt | ✅ | `--python` |
| **JavaScript** | 18.17.0 | nvm | ✅ | `--node` |
| **TypeScript** | 5.x | npm | ✅ | `--node` |

**Databases:** PostgreSQL (`--with-postgres`), MongoDB (`--with-mongo`)

## 📂 Algorithm Categories

- **sorting/** - Bubble, Quick, Merge, Heap sorts
- **searching/** - Binary, Linear, DFS searches  
- **data_structures/** - Linked lists, Trees, Stacks, Queues
- **dynamic_programming/** - Fibonacci, LCS, Knapsack
- **graph_algorithms/** - Dijkstra, BFS, DFS

## 💻 Usage Examples

```bash
# Run algorithm in any language
cd sorting/bubble_sort
ruby bubble_sort.rb
python bubble_sort.py
node bubble_sort.js
ts-node bubble_sort.ts

# Run challenges easily with the run script (recommend use the alias, look next section)
cd code-challenges/your-challenge-name
../../scripts/run.sh ts  # for TypeScript
../../scripts/run.sh js  # for JavaScript
../../scripts/run.sh py  # for Python
../../scripts/run.sh rb  # for Ruby

# After devcontainer rebuild, use the alias
run-challenge ts  # for TypeScript
run-challenge js  # for JavaScript
run-challenge py  # for Python
run-challenge rb  # for Ruby

# Debug with breakpoints
## Ruby
debugger
rdbg solution.rb
```

## 🔄 Version Management

```bash
switch-ruby    # Show Ruby versions
switch-python  # Show Python versions  
switch-node    # Show Node versions

# Switch versions
rvm use 3.3.0
pyenv global 3.12.0
nvm use 20.0.0
```

## ✅ Health Check

```bash
# Check installed runtimes
ruby --version && python --version && node --version && tsc --version

# Test build system
cd .devcontainer && ./build.sh --help

# Test run-challenge alias
run-challenge --help  # Should show usage information
```

## 🔧 Troubleshooting

### `run-challenge` alias not working?

The `run-challenge` alias should be automatically set up when the devcontainer is created. If it's missing:

```bash
# Option 1: Reload your shell configuration
source ~/.bashrc

# Option 2: Manually add the alias (temporary)
alias run-challenge='/workspaces/Algorithms/scripts/run.sh'

# Option 3: Rebuild devcontainer (permanent fix)
# In VS Code: Ctrl+Shift+P → "Dev Containers: Rebuild Container"
```

The alias is defined in:
- Added to `.bashrc` during container creation
- Setup automated via `.devcontainer/setup-aliases.sh` script
- Triggered by `.devcontainer/devcontainer.json` postCreateCommand

## 📚 More Info

- **Modular Architecture:** See `docs/devcontainer_modular.md` for advanced usage
- **Custom Stacks:** Build different environments for different projects
- **Database Support:** Add PostgreSQL or MongoDB with build flags
