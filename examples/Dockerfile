# Copyright 2020 Google LLC
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

# Use an R image.
# https://hub.docker.com/r/rstudio/plumber/
FROM rstudio/plumber

# Install functions framework dependencies.
RUN R -e "install.packages('optparse', dependencies=TRUE, quiet=TRUE)"

# Copy R package binary
COPY functionsframework_*.tar.gz /
RUN R CMD INSTALL functionsframework_*.tar.gz

# Remove R package binary
RUN rm functionsframework_*.tar.gz

# Copy local code to the container image.
COPY *.R /

# Run the web service on container startup.
ENTRYPOINT [ "Rscript", "create-app.R", "--target", "hello" ]
