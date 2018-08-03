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

Once the image is built, run the following command to output the results from [poker.txt](https://github.com/pwentz/poker-hands/blob/master/public/poker.txt):

```
docker-compose run app ruby main.rb
```

You can also pass the app a text file (in the same format) and it will calculate the result of those hands:

```
docker-compose run app ruby main.rb path/to/file.txt
```

### Tests

Once the image is built, tests can be run with the following command:
```
docker-compose run app rspec
```
