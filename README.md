### Requirements

All you need is [Docker](https://store.docker.com/search?type=edition&offering=community) to be able to run the app locally.

Downloading the Docker binaries from their website is the preferred approach, but if you wish to install via Homebrew:

```
brew install docker
```

### Getting Started

Build the docker container with the following command:
```
docker-compose build
```

Once the image is built, run the following command to output the results:

```
docker-compose run app ruby main.rb
```

### Tests

Once the image is built, tests can be run with the following command:
```
docker-compose run app rspec
```
