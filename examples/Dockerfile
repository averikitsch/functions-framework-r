# Use an R image.
# https://hub.docker.com/r/rocker/r-ver/
FROM rocker/r-ver:3.6.0
# Create and change to the app directory.
WORKDIR /usr/src/app
# Install production dependencies.
RUN R -e "install.packages('functionsframework')"
# Copy local code to the container image.
COPY *.R .
# Run the web service on container startup.
CMD [ "Rscript", "create-app.R", "--target hello" ]
