# LOCAL SETUP

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Development](#development)

## Getting Started
To get a local copy up and running follow these simple example steps.

<!-- PREREQUISITES -->
### Prerequisites

- **Docker & Docker Compose**
  - https://docs.docker.com/compose/install/

<!-- INSTALLATION -->
### Installation

1. Clone the repo
```sh
git clone https://github.com/mbronek7/usi-ue.git
```
2. From your project directory create docker network
```sh
make network
```
3. From your project directory build docker image of app and boot application
```sh
make dev
```
4. Stop application and clean docker
```sh
make clean
```
5. If you will have some problems with detection, try to reinstall model:
```sh
make fix_model
```
