Container image for scooter - Interactive find and replace in the terminal

## Usage

### Start

```shell
docker run --rm -it --volume=$(pwd):/workspace ghcr.io/r-xs-fi/scooter 
```

## Supported platforms


| OS    | Architecture  | Supported | Example hardware |
|-------|---------------|-----------|-------------|
| Linux | amd64 | ✅       | Regular PCs (also known as x64-64) |
| Linux | arm64 | ❌ (rust cross compile not yet implemented)       | Raspberry Pi with 64-bit OS, other single-board computers, Apple M1 etc. |
| Linux | arm/v7 | ❌ (rust cross compile not yet implemented)       | Raspberry Pi with 32-bit OS, older phones |
| Linux | riscv64 | ❌ (rust cross compile not yet implemented)       | More exotic hardware |
