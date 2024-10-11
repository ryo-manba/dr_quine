COLLEEN = Colleen
GRACE   = Grace
SULLY   = Sully

NAMES = $(COLLEEN) $(GRACE) $(SULLY)
SRCS = Colleen.js Grace.js Sully.js

.PHONY: all
all: $(NAMES)

.PHONY: clean
clean:
	rm -rf tmp_Colleen Grace_kid.js Sully_*

$(COLLEEN):
	node Colleen.js

$(GRACE):
	node Grace.js

$(SULLY):
	node Sully.js

.PHONY: test
test: test-c test-g test-s

.PHONY: test-colleen test-c
test-colleen:
	node Colleen.js > tmp_Colleen ; diff tmp_Colleen Colleen.js

test-c: test-colleen

.PHONY: test-grace test-g
test-grace:
	node Grace.js ; diff Grace_kid.js Grace.js

test-g: test-grace

.PHONY: test-sully test-s
test-sully: $(SULLY)
	node Sully.js
	for n in {5..0}; do \
		diff Sully.js Sully_$$n.js || echo "Difference found in Sully_$$n.js"; \
	done

test-s: test-sully