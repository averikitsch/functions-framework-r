# Functions Framework for R
An open source FaaS (Function as a service) framework for writing portable
R functions.

The Functions Framework lets you write lightweight functions that run in many
different environments, including:

*   [Google Cloud Functions](https://cloud.google.com/functions/)
*   Your local development machine
*   [Cloud Run and Cloud Run for Anthos](https://cloud.google.com/run/)
*   [Knative](https://github.com/knative/)-based environments

The framework allows you to go from:

```R
hello <- function(req, res){
  return("Hello World!")
}
```

To:

```sh
curl http://my-url
# Output: Hello world!
```

All without needing to worry about writing an HTTP server or complicated request handling logic.

# Features

*   Spin up a local development server for quick testing
*   Invoke a function in response to a request
*   Automatically unmarshal events conforming to the [CloudEvents](https://cloudevents.io/) spec
*   Portable between serverless platforms

# Installation

```sh
library(devtools)
install_github("averikitsch/functions-framework-r/src/functionsframework")
```

# Quickstart: Hello, World on your local machine

Create a `main.R` file with the following contents:

```R
hello <- function(req, res){
  return("Hello World!")
}
```

Create a `create-app.R` file with the following contents:

```R
library(functionsframework)
createApp()
```
or add to the end of `main.R`.

Run the following command:

```sh
Rscript create-app.R --target=hello
```

Open http://localhost:8080/ in your browser and see *Hello world!*.

# Run your function on serverless platforms

## Cloud Run/Cloud Run on GKE

Once you've written your function and added the Functions Framework to your file, all that's left is to create a container image. [Check out the Cloud Run quickstart](examples/) to create a container image and deploy it to Cloud Run. You'll write a `Dockerfile` when you build your container. This `Dockerfile` allows you to specify exactly what goes into your container (including custom binaries, a specific operating system, and more).

If you want even more control over the environment, you can [deploy your container image to Cloud Run on GKE](https://cloud.google.com/run/docs/quickstarts/prebuilt-deploy-gke). With Cloud Run on GKE, you can run your function on a GKE cluster, which gives you additional control over the environment (including use of GPU-based instances, longer timeouts and more).

## Container environments based on Knative

Cloud Run and Cloud Run on GKE both implement the [Knative Serving API](https://www.knative.dev/docs/). The Functions Framework is designed to be compatible with Knative environments. Just build and deploy your container to a Knative environment.

# Configure the Functions Framework

You can configure the Functions Framework using command-line flags or environment variables. If you specify both, the environment variable will be ignored.

Command-line flag         | Environment variable      | Description
------------------------- | ------------------------- | -----------
`--port`                    | `PORT`                    | The port on which the Functions Framework listens for requests. Default: `8080`
`--target`         | `FUNCTION_TARGET`         | The name of the exported function to be invoked in response to requests. Default: `function`
`--signature-type` | `FUNCTION_SIGNATURE_TYPE` | The signature used when writing your function. Controls unmarshalling rules and determines which arguments are used to invoke your function. Default: `http`; accepted values: `http` or `event`
`--source`         | `FUNCTION_SOURCE`         | The path to the file containing your function. Default: `main.R` (in the current working directory)

# Contributing

Contributions to this library are welcome and encouraged. See [CONTRIBUTING](CONTRIBUTING.md) for more information on how to get started.
