1. Install:
  ```R
  install.packages("devtools")
  install.packages("roxygen2")
  ```

1. Create framework package:
  ```R
  devtools::create("functionsframework")
  ```

  * Update files: DESCRIPTION and NAMESPACE
  * Add imports

1. Add `roxygen2` documentation for function, then run:
  ```R
  devtools::document()
  ```

  * This creates an `.Rd` file in the `man/` directory

1.

devtools::use_vignette("introduction")

1. Install package by running command in package directory:
  ```R
  devtools::install()
  ```
