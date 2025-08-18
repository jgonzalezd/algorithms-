# Modular Devcontainer System

This project uses a **modular devcontainer architecture** that allows you to build custom development environments by choosing exactly which runtimes and databases you need.

## 🎯 Quick Start

### Option 1: Use the Build Script (Recommended)

```bash
cd .devcontainer

# All runtimes (default)
./build.sh

# Just Node.js
./build.sh --node-only

# Ruby + Python with PostgreSQL
./build.sh --ruby --python --with-postgres

# Node.js with MongoDB
./build.sh --node-only --with-mongo

# See all options
./build.sh --help
```

### Option 2: Manual Docker Compose

Edit `docker-compose.yml` build args manually, then:

```bash
cd .devcontainer
docker-compose build
```

## 🏗️ Architecture

The modular system works by stacking Docker layers conditionally:

```
┌─────────────────────────────────┐
│         Final Dev Image         │ ← You get this
├─────────────────────────────────┤
│      Python Layer (optional)   │
├─────────────────────────────────┤
│      Ruby Layer (optional)     │
├─────────────────────────────────┤
│      Node.js Layer (optional)  │
├─────────────────────────────────┤
│      Base System Layer         │ ← Always included
└─────────────────────────────────┘
```

**Key Benefits:**
- ✅ **Selective builds** - Only install what you need
- ✅ **Faster builds** - Conditional layers skip unused runtimes  
- ✅ **No conflicts** - Each runtime is isolated during install
- ✅ **Easy customization** - Change versions or add databases
- ✅ **Reproducible** - Same build args = same environment

## 🛠️ Available Configurations

### Runtime Options

| Flag | Effect | Default |
|------|--------|---------|
| `--node-only` | Just Node.js + TypeScript | - |
| `--ruby-only` | Just Ruby + Bundler | - |
| `--python-only` | Just Python + pip | - |
| `--minimal` | No runtimes, base system only | - |
| `--all` | All runtimes | ✅ |
| `--node / --no-node` | Toggle Node.js | ✅ |
| `--ruby / --no-ruby` | Toggle Ruby | ✅ |
| `--python / --no-python` | Toggle Python | ✅ |

### Database Options

| Flag | Effect | Connection |
|------|--------|------------|
| `--with-postgres` | Add PostgreSQL service | `localhost:5432` |
| `--with-mongo` | Add MongoDB service | `localhost:27017` |

### Version Options

| Flag | Default | Example |
|------|---------|---------|
| `--node-version` | 18.17.0 | `--node-version 20.0.0` |
| `--ruby-version` | 3.2.0 | `--ruby-version 3.3.0` |
| `--python-version` | 3.11 | `--python-version 3.12` |

## 📋 Common Use Cases

### Web Development Stacks

```bash
# Full-stack JavaScript
./build.sh --node-only --with-postgres

# Ruby on Rails
./build.sh --ruby-only --with-postgres

# Python Django/Flask
./build.sh --python-only --with-postgres

# MEAN/MERN stack
./build.sh --node-only --with-mongo
```

### Algorithm Study (Current Project)

```bash
# All languages for algorithm practice
./build.sh --all

# Focus on specific language
./build.sh --python-only
./build.sh --node-only  
./build.sh --ruby-only
```

### Microservices Development

```bash
# Service A (Node.js API)
./build.sh --node-only --with-postgres

# Service B (Python ML)  
./build.sh --python-only --with-mongo

# Gateway (Ruby)
./build.sh --ruby-only
```

## 🔧 Technical Details

### Layer Structure

Each layer is a Docker `FROM ... AS ...` stage that conditionally installs:

1. **Base Layer** (`base`) - Ubuntu 22.04, system packages, non-root user
2. **Node Layer** (`node`) - NVM + Node.js + TypeScript (if `WITH_NODE=true`)
3. **Ruby Layer** (`ruby`) - RVM + Ruby + Bundler (if `WITH_RUBY=true`)  
4. **Python Layer** (`python`) - Python + pip via apt (if `WITH_PYTHON=true`)
5. **Final Layer** (`dev`) - Sets workspace, health checks

### Build Arguments

The Dockerfile accepts these build args:

```dockerfile
ARG WITH_NODE=true
ARG WITH_RUBY=true  
ARG WITH_PYTHON=true
ARG NODE_VERSION=18.17.0
ARG RUBY_VERSION=3.2.0
ARG PYTHON_VERSION=3.11
```

### Database Services

Databases run as separate Docker Compose services:

- **PostgreSQL**: `postgres:15` with dev credentials
- **MongoDB**: `mongo:6` with dev credentials

## 🐛 Troubleshooting

### Build Failures

1. **NVM not found**: The new architecture uses `bash -ic` to properly load NVM
2. **Permission denied**: Ensure `build.sh` is executable (`chmod +x build.sh`)
3. **Docker out of space**: Prune old images (`docker system prune`)

### Common Issues

| Issue | Solution |
|-------|----------|
| Node.js commands fail | Check that `WITH_NODE=true` in build |
| Ruby gems missing | Ensure `source ~/.rvm/scripts/rvm` in shell |
| Python not found | Verify `WITH_PYTHON=true` and restart container |
| Database connection refused | Check that database service is uncommented in compose |

### Debugging Commands

```bash
# Check what's installed
docker-compose exec app bash -ic "node --version"
docker-compose exec app bash -lc "ruby --version"  
docker-compose exec app python --version

# View build logs
docker-compose build --no-cache app

# Check services
docker-compose ps
```

## 🚀 Extending the System

### Adding New Runtimes

1. Create `layers/go.Dockerfile`:
   ```dockerfile
   FROM base AS go
   ARG WITH_GO
   ARG GO_VERSION
   RUN if [ "$WITH_GO" = "true" ]; then \
       # Install Go here
   fi
   ```

2. Add Go layer to main `Dockerfile`:
   ```dockerfile
   FROM python AS go
   ARG WITH_GO
   # ... install Go conditionally
   ```

3. Update `build.sh` with `--go` flag

### Adding New Databases

1. Add service to `docker-compose.yml`:
   ```yaml
   redis:
     image: redis:7
     networks: [devnet]
     ports: ["6379:6379"]
   ```

2. Update `build.sh` with `--with-redis` flag

### Custom Project Templates

Create project-specific build scripts:

```bash
# .devcontainer/presets/fullstack-js.sh
./build.sh --node-only --with-postgres --with-redis

# .devcontainer/presets/data-science.sh  
./build.sh --python-only --with-postgres
```

## 📁 File Structure

```
.devcontainer/
├── Dockerfile              # Main modular Dockerfile
├── docker-compose.yml      # Generated by build.sh
├── devcontainer.json       # VS Code configuration
├── build.sh               # Build script with options
└── layers/                # Individual layer Dockerfiles
    ├── base.Dockerfile     # Base system setup
    ├── node.Dockerfile     # Node.js via NVM
    ├── ruby.Dockerfile     # Ruby via RVM
    └── python.Dockerfile   # Python via apt
```

This architecture solves the original build failure issues while providing maximum flexibility for different project types!
