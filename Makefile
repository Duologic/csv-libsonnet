.PHONY: test
test:
	jrsonnet -J ./test/vendor ./test/main.libsonnet
