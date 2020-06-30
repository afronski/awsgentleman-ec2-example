.PHONY: build test clean

all: jar-clean jar-build jar-test

STAGE=dev
VERSION=$(shell cat build.gradle | grep 'version =' | cut -d'=' -f2 | tr -d "'" | tr -d " ")
JAR_FILE=build/libs/service-example-${VERSION}.jar

build: jar-build
test: jar-test
clean: jar-clean

jar-clean:
	./gradlew clean

jar-test:
	./gradlew test

jar-build:
	./gradlew assemble
