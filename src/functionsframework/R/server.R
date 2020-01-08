# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Create App
#' Functions framework entry point that configures and starts web server
#' that runs user's code on HTTP request.
#' The following environment variables can be set to configure the framework:
#'   - PORT - defines the port on which this server listens to all HTTP
#'     requests.
#'   - FUNCTION_TARGET - defines the name of the function within user's
#'     node module to execute. If such a function is not defined,
#'     then falls back to 'function' name.
#'   - FUNCTION_SIGNATURE_TYPE - defines the type of the client function
#'     signature, 'http' for function signature with HTTP request and HTTP
#'     response arguments, or 'event' for function signature with arguments
#'     unmarshalled from an incoming request.
#' The server accepts following HTTP requests:
#'   - POST '/*' for executing functions (only for servers handling functions
#'     with non-HTTP trigger).
#'   - ANY (all methods) '/*' for executing functions (only for servers handling
#'     functions with HTTP trigger).
#'
#' @return None
#' @export
createApp <- function() {
  # Get CLI args
  option_list = list(
    optparse::make_option("--port", type="integer",
    default=strtoi(Sys.getenv("PORT", 8080)),
    help="Web server port", metavar="character"),
    optparse::make_option("--target", type="character",
    default=Sys.getenv("FUNCTION_TARGET", "function"),
    help="Function name", metavar="character"),
    optparse::make_option("--source", type="character",
    default=Sys.getenv("FUNCTION_SOURCE", "main.R"),
    help="Function source", metavar="character"),
    optparse::make_option("--signature_type", type="character",
    default=Sys.getenv("FUNCTION_SIGNATURE_TYPE", "http"),
    help="Type of function HTTP or Event", metavar="character")
  );

  opt_parser = optparse::OptionParser(option_list=option_list);
  opt = optparse::parse_args(opt_parser);
  #TODO debug?

  # Validate CLI args
  if (!(tolower(opt$signature_type) %in% c('http', 'event'))) {
    stop("Function signature type must be one of 'http' or 'event'.")
  }
  if (!file.exists(opt$source)) {
    stop(paste("File", opt$source, "that is expected to define function doesn't exist", sep=" "))
  }

  # Load source
  args <- commandArgs()
  file <- sub("--file=", "", args[4])
  if (file != opt$source) {
    source(opt$source)
  }
  if (!exists(opt$target, mode="function")) {
    stop(paste("File", opt$source, "is expected to contain a function named", opt$target, sep=" "))
  }

  # Create a new handler
  pr <- plumber::plumber$new()
  method <- c("GET", "PUT", "POST", "DELETE", "HEAD", "OPTIONS", "PATCH")
  pr$handle(method, "/", function(req, res){
    # Call function
    do.call(opt$target, list(req, res))
  })
  # Run server
  pr$run(port=opt$port, host="0.0.0.0")
}
