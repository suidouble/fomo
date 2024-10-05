# Define variables
PACKAGE_NAME = fomo
GAS_BUDGET = 1000
PACKAGE_PATH = .
BUILD_DIR = $(PACKAGE_PATH)/build
SOURCES_DIR = $(PACKAGE_PATH)/sources
TESTS_DIR = $(PACKAGE_PATH)/tests

# Default target
all: build

# Build contracts
build:
	@echo "Building the Move package..."
	sui move build --path $(PACKAGE_PATH)

# Publish contracts
publish:
	@echo "Publishing the Move package..."
	sui client publish --path $(PACKAGE_PATH) --gas-budget $(GAS_BUDGET)

# Test contracts
test:
	@echo "Running tests..."
	sui move test --path $(PACKAGE_PATH) --skip-fetch-latest-git-deps --gas-limit=10000000000000000

# Clean build directory
clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)

# Show help
help:
	@echo "Makefile for Sui Move project"
	@echo ""
	@echo "Usage:"
	@echo "  make build	 - Build the Move package"
	@echo "  make publish   - Publish the Move package"
	@echo "  make test	  - Run tests"
	@echo "  make clean	 - Clean build directory"
	@echo "  make help	  - Show this help message"

.PHONY: all build publish test clean help