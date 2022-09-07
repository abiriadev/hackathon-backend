# Usgae:
# 
# make compile:
# 	compile typescript code into javascript
# 
# make watch:
# 	watch source directory for changes and compile it automatically
# 
# make watch-oas:
# 	watch openapi documentation file and build it again whenever it changes
# 
# make clean:
# 	cleans up build artifacts

.PHONY: \
	all \
	watch \
	watch-oas \
	compile \
	lint \
	bundle \
	out \
	clean \
	pre-commit

SOURCE_DIR := src
OPENAPI_DIR := schemas
TEST_RUNNER := jest
COMPILER := swc
OPENAPI_DOC := ${OPENAPI_DIR}/openapi.yaml
OUT_DIR := dist
BUNDLE_FILE_EXT := yaml
BUNDLE_FILE := bundle.${BUNDLE_FILE_EXT}
MODULE_PATH := node_modules
WATCHER := chokidar
LINTER := @redocly/cli
LINTER_OPTIONS := --format codeframe # stylish

all:

out: # ${OUT_DIR}
	mkdir -p ${OUT_DIR}

watch-oas: \
	${OPENAPI_DOC} \
	${MODULE_PATH}/${WATCHER} \
	${MODULE_PATH}/${LINTER}

	npx ${WATCHER} ${OPENAPI_DIR} \
		-i ${OPENAPI_DIR}/${BUNDLE_FILE} \
		--verbose \
		-c "make push"

lint: \
	${OPENAPI_DOC} \
	${MODULE_PATH}/${LINTER}

	npx ${LINTER} lint ${OPENAPI_DOC} ${LINTER_OPTIONS}

bundle: \
	${OPENAPI_DOC} \
	${MODULE_PATH}/${LINTER} \
	out

	npx ${LINTER} bundle ${OPENAPI_DOC} \
		--output ${OUT_DIR}/${BUNDLE_FILE} \
		--ext ${BUNDLE_FILE_EXT} \
		--lint # optional

pre-commit: \
	lint

	true

clean:
	rm -r ${OUT_DIR}

generate: \
	${OUT_DIR}/${BUNDLE_FILE}

	bin/generate.sh

compile: \
	${MODULE_PATH}/@${COMPILER}

	npx ${COMPILER} ${SOURCE_DIR} -d ${OUT_DIR}

watch: \
	${MODULE_PATH}/${WATCHER} \
	${MODULE_PATH}/@${COMPILER}

	npx ${COMPILER} ${SOURCE_DIR} -wd ${OUT_DIR}

test: \
	${MODULE_PATH}/${TEST_RUNNER}

	npx ${TEST_RUNNER}
