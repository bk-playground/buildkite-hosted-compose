# buildkite-hosted-compose

[![Add to Buildkite](https://buildkite.com/button.svg)](https://buildkite.com/new)

This project illustrates how to use Docker Compose to build a rails app development container while ensuring this container can be cached and reused across multiple steps, and subsequent builds.

## How it works

Buildkite hosted agents provides two features which enable this:

* Docker builder is configured in each agent container which results in improved build times, and reuse of the same container across multiple steps.
* Container cache volume is mounted in each agent container which allows the cache to be shared across multiple steps, and subsequent builds.

[Development Dockerfile](Dockerfile.development) is used to build the development container. This Dockerfile is optimized for caching by ensuring that the dependencies are installed in a separate layer from the application code.
[Buildkite pipeline](.buildkite/pipeline.yaml) is configured to use docker compose to build the development container in the first step, and then use the same container in subsequent steps.

## How to use

1. Setup a cluster and queue in buildkite which is configured to use hosted agents.
2. Enable docker caching in the cluster settings.
3. Clone this repository and push it to your github account.
4. Create a new pipeline in buildkite and point it to the repository
5. Add pipeline with a single command (see yaml below) to upload the pipeline yaml.
6. Run the pipeline.

```yaml
steps:
  - label: "Upload pipeline"
    command: buildkite pipeline upload .buildkite/pipeline.yaml
```

The first build will take longer as the development container is built. Subsequent builds will be faster as the container is cached and reused.