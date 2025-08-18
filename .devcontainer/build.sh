#!/bin/bash

# Modular Devcontainer Builder
# Usage: ./build.sh [options]
# 
# Examples:
#   ./build.sh --node-only                    # Just Node.js
#   ./build.sh --ruby --python                # Ruby + Python, no Node
#   ./build.sh --all --with-postgres          # All runtimes + PostgreSQL
#   ./build.sh --minimal                      # Just base system, no runtimes

set -e

# Default values
WITH_NODE="true"
WITH_RUBY="true"
WITH_PYTHON="true"
NODE_VERSION="18.17.0"
RUBY_VERSION="3.2.0"
PYTHON_VERSION="3.11"
WITH_POSTGRES="false"
WITH_MONGO="false"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --node-only)
            WITH_NODE="true"
            WITH_RUBY="false"
            WITH_PYTHON="false"
            shift
            ;;
        --ruby-only)
            WITH_NODE="false"
            WITH_RUBY="true"
            WITH_PYTHON="false"
            shift
            ;;
        --python-only)
            WITH_NODE="false"
            WITH_RUBY="false"
            WITH_PYTHON="true"
            shift
            ;;
        --minimal)
            WITH_NODE="false"
            WITH_RUBY="false"
            WITH_PYTHON="false"
            shift
            ;;
        --all)
            WITH_NODE="true"
            WITH_RUBY="true"
            WITH_PYTHON="true"
            shift
            ;;
        --node)
            WITH_NODE="true"
            shift
            ;;
        --no-node)
            WITH_NODE="false"
            shift
            ;;
        --ruby)
            WITH_RUBY="true"
            shift
            ;;
        --no-ruby)
            WITH_RUBY="false"
            shift
            ;;
        --python)
            WITH_PYTHON="true"
            shift
            ;;
        --no-python)
            WITH_PYTHON="false"
            shift
            ;;
        --with-postgres)
            WITH_POSTGRES="true"
            shift
            ;;
        --with-mongo)
            WITH_MONGO="true"
            shift
            ;;
        --node-version)
            NODE_VERSION="$2"
            shift 2
            ;;
        --ruby-version)
            RUBY_VERSION="$2"
            shift 2
            ;;
        --python-version)
            PYTHON_VERSION="$2"
            shift 2
            ;;
        --help|-h)
            echo "Modular Devcontainer Builder"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Runtime Options:"
            echo "  --node-only          Enable only Node.js"
            echo "  --ruby-only          Enable only Ruby"
            echo "  --python-only        Enable only Python"
            echo "  --minimal            No runtimes, just base system"
            echo "  --all                Enable all runtimes (default)"
            echo ""
            echo "  --node / --no-node           Enable/disable Node.js"
            echo "  --ruby / --no-ruby           Enable/disable Ruby"
            echo "  --python / --no-python       Enable/disable Python"
            echo ""
            echo "Database Options:"
            echo "  --with-postgres      Add PostgreSQL service"
            echo "  --with-mongo         Add MongoDB service"
            echo ""
            echo "Version Options:"
            echo "  --node-version VER   Node.js version (default: $NODE_VERSION)"
            echo "  --ruby-version VER   Ruby version (default: $RUBY_VERSION)"
            echo "  --python-version VER Python version (default: $PYTHON_VERSION)"
            echo ""
            echo "Examples:"
            echo "  $0 --node-only --with-postgres"
            echo "  $0 --ruby --python --with-mongo"
            echo "  $0 --all --node-version 20.0.0"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Update docker-compose.yml with database services
compose_file="docker-compose.yml"
temp_compose=$(mktemp)

# Base compose content
cat > "$temp_compose" << EOF
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        WITH_NODE: "$WITH_NODE"
        WITH_RUBY: "$WITH_RUBY" 
        WITH_PYTHON: "$WITH_PYTHON"
        NODE_VERSION: "$NODE_VERSION"
        RUBY_VERSION: "$RUBY_VERSION"
        PYTHON_VERSION: "$PYTHON_VERSION"
    volumes:
      - ../..:/workspaces:cached
    command: sleep infinity
    networks:
      - devnet
EOF

# Add database services if requested
if [ "$WITH_POSTGRES" = "true" ]; then
    cat >> "$temp_compose" << EOF

  postgres:
    image: postgres:15
    restart: unless-stopped
    environment:
      POSTGRES_USER: devuser
      POSTGRES_PASSWORD: devpass
      POSTGRES_DB: devdb
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - devnet
    ports:
      - "5432:5432"
EOF
fi

if [ "$WITH_MONGO" = "true" ]; then
    cat >> "$temp_compose" << EOF

  mongo:
    image: mongo:6
    restart: unless-stopped
    environment:
      MONGO_INITDB_ROOT_USERNAME: devuser
      MONGO_INITDB_ROOT_PASSWORD: devpass
    volumes:
      - mongo-data:/data/db
    networks:
      - devnet
    ports:
      - "27017:27017"
EOF
fi

# Add networks
cat >> "$temp_compose" << EOF

networks:
  devnet:
EOF

# Add volumes only if databases are selected
if [ "$WITH_POSTGRES" = "true" ] || [ "$WITH_MONGO" = "true" ]; then
    echo "" >> "$temp_compose"
    echo "volumes:" >> "$temp_compose"
    
    if [ "$WITH_POSTGRES" = "true" ]; then
        echo "  postgres-data:" >> "$temp_compose"
    fi
    
    if [ "$WITH_MONGO" = "true" ]; then
        echo "  mongo-data:" >> "$temp_compose"
    fi
fi

# Replace the compose file
mv "$temp_compose" "$compose_file"

# Print configuration summary
echo "🏗️  Building devcontainer with:"
echo "   Node.js: $WITH_NODE $([ "$WITH_NODE" = "true" ] && echo "($NODE_VERSION)")"
echo "   Ruby:    $WITH_RUBY $([ "$WITH_RUBY" = "true" ] && echo "($RUBY_VERSION)")"
echo "   Python:  $WITH_PYTHON $([ "$WITH_PYTHON" = "true" ] && echo "($PYTHON_VERSION)")"
echo "   PostgreSQL: $WITH_POSTGRES"
echo "   MongoDB:    $WITH_MONGO"
echo ""

# Build the container
echo "🚀 Building Docker image..."
docker compose build

echo ""
echo "✅ Build complete! The devcontainer is ready to use."
echo ""
echo "To use this configuration:"
echo "1. Open VS Code in this directory"
echo "2. Use 'Dev Containers: Reopen in Container' command"
echo ""

if [ "$WITH_POSTGRES" = "true" ] || [ "$WITH_MONGO" = "true" ]; then
    echo "Database connection info:"
    if [ "$WITH_POSTGRES" = "true" ]; then
        echo "  PostgreSQL: localhost:5432, user: devuser, password: devpass, db: devdb"
    fi
    if [ "$WITH_MONGO" = "true" ]; then
        echo "  MongoDB: localhost:27017, user: devuser, password: devpass"
    fi
    echo ""
fi
