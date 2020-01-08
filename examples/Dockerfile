# Use an R image.
# https://hub.docker.com/r/rocker/r-ver/
FROM rocker/r-ver:3.6.1

# Copy R package binary
COPY functionsframework_*.tgz /

# Install functions framework dependencies.
RUN R -e "install.packages('functionsframework_0.0.0.9000.tgz', repos = NULL, type = 'source')"
RUN R -e "install.packages(c('optparse', 'plumber'))"

# Remove R package binary
RUN rm functionsframework_*.tgz

# Copy local code to the container image.
COPY *.R /

# Run the web service on container startup.
CMD [ "Rscript", "create-app.R", "--target", "hello" ]
