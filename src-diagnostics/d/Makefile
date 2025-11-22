# Makefile for Juisys Diagnostics (D implementation)
#
# Build dynamic library for integration with Julia

# Compiler
DMD = dmd
LDC = ldc2
GDC = gdc

# Default compiler (LDC recommended for production)
DC = $(LDC)

# Flags
DFLAGS_COMMON = -fPIC -shared
DFLAGS_DEBUG = -g -d-debug
DFLAGS_RELEASE = -O3 -release -inline

# Output
ifeq ($(shell uname),Darwin)
    LIB_EXT = .dylib
else
    LIB_EXT = .so
endif

LIB_NAME = libdiagnostics$(LIB_EXT)

# Sources
SOURCES = diagnostics.d developer_diagnostics.d

# Targets
.PHONY: all debug release clean install test

all: release

debug:
	@echo "Building debug version..."
	$(DC) $(DFLAGS_COMMON) $(DFLAGS_DEBUG) $(SOURCES) -of=$(LIB_NAME)
	@echo "✓ Debug build complete: $(LIB_NAME)"

release:
	@echo "Building release version..."
	$(DC) $(DFLAGS_COMMON) $(DFLAGS_RELEASE) $(SOURCES) -of=$(LIB_NAME)
	@echo "✓ Release build complete: $(LIB_NAME)"
	@echo ""
	@echo "To use with Juisys:"
	@echo "  1. Copy $(LIB_NAME) to a library path"
	@echo "  2. Enable diagnostics in Julia: enable_diagnostics()"

clean:
	@echo "Cleaning build artifacts..."
	rm -f $(LIB_NAME) *.o *.di
	@echo "✓ Clean complete"

install:
	@echo "Installing library..."
	mkdir -p /usr/local/lib/juisys/
	cp $(LIB_NAME) /usr/local/lib/juisys/
	@echo "✓ Installed to /usr/local/lib/juisys/$(LIB_NAME)"

test:
	@echo "Building and running test..."
	$(DC) -unittest -main -g $(SOURCES) -of=test_diagnostics
	./test_diagnostics
	rm -f test_diagnostics
	@echo "✓ Tests passed"

# DUB alternative
dub-build:
	@echo "Building with DUB..."
	dub build --build=release
	@echo "✓ DUB build complete"

# Help
help:
	@echo "Juisys Diagnostics Build System"
	@echo ""
	@echo "Targets:"
	@echo "  make              - Build release version"
	@echo "  make debug        - Build debug version"
	@echo "  make release      - Build optimized release"
	@echo "  make clean        - Remove build artifacts"
	@echo "  make install      - Install library system-wide"
	@echo "  make test         - Run unit tests"
	@echo "  make dub-build    - Build with DUB package manager"
	@echo ""
	@echo "Compilers supported:"
	@echo "  DC=dmd make       - Use DMD compiler"
	@echo "  DC=ldc2 make      - Use LDC compiler (default, recommended)"
	@echo "  DC=gdc make       - Use GDC compiler"
