# Development Notes

## Install from source

* Install dependencies:

```R
install.packages(c("optparse", "plumber"))
```

* Install package from root directory:

```R
install.packages("src/functionsframework/", repo=NULL, type="source")
```

or

```R
devtools::install()
```

## Install from repo

```R
install.packages("remotes")
remotes::install_github("averikitsch/functions-framework-r")
```

```R
install.packages("devtools")
devtools::install_github()
```

When published:
```R
install.packages("functionsframework", dependencies=TRUE)
```

## Create documentation

1. Install:
  ```R
  install.packages("devtools")
  install.packages("roxygen2")
  ```

1. Create framework package (run once):

  ```R
  devtools::create("functionsframework")
  ```

  * Update files: DESCRIPTION and NAMESPACE
  * Add dependencies

1. Add `roxygen2` documentation for function, then run:

  ```R
  devtools::document()
  ```

  * This creates an `.Rd` file in the `man/` directory

1. Update rmarkdown in `vignettes/functions-framework.Rmd`:

  ```R
  devtools::build_vignettes()
  ```

## Create tar file

  ```R
  devtools::build()
  ```
