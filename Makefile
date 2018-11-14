# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gaux android ios gaux-cross swarm evm all test clean
.PHONY: gaux-linux gaux-linux-386 gaux-linux-amd64 gaux-linux-mips64 gaux-linux-mips64le
.PHONY: gaux-linux-arm gaux-linux-arm-5 gaux-linux-arm-6 gaux-linux-arm-7 gaux-linux-arm64
.PHONY: gaux-darwin gaux-darwin-386 gaux-darwin-amd64
.PHONY: gaux-windows gaux-windows-386 gaux-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

gaux:
	build/env.sh go run build/ci.go install ./cmd/gaux
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gaux\" to launch gaux."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gaux.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gaux.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

lint: ## Run linters.
	build/env.sh go run build/ci.go lint

clean:
	./build/clean_go_build_cache.sh
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gaux-cross: gaux-linux gaux-darwin gaux-windows gaux-android gaux-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gaux-*

gaux-linux: gaux-linux-386 gaux-linux-amd64 gaux-linux-arm gaux-linux-mips64 gaux-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-*

gaux-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gaux
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep 386

gaux-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gaux
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep amd64

gaux-linux-arm: gaux-linux-arm-5 gaux-linux-arm-6 gaux-linux-arm-7 gaux-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep arm

gaux-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gaux
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep arm-5

gaux-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gaux
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep arm-6

gaux-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gaux
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep arm-7

gaux-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gaux
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep arm64

gaux-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gaux
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep mips

gaux-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gaux
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep mipsle

gaux-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gaux
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep mips64

gaux-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gaux
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gaux-linux-* | grep mips64le

gaux-darwin: gaux-darwin-386 gaux-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gaux-darwin-*

gaux-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gaux
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-darwin-* | grep 386

gaux-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gaux
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-darwin-* | grep amd64

gaux-windows: gaux-windows-386 gaux-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gaux-windows-*

gaux-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gaux
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-windows-* | grep 386

gaux-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gaux
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gaux-windows-* | grep amd64
