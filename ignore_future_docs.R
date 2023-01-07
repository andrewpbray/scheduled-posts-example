
# Read in schedule data
x <- yaml::read_yaml("_schedule.yml")

# Change path of docs to be published in the future so that
# they're prepended with _ to have them ignored during render
# See https://quarto.org/docs/websites/index.html#render-targets

ignore_future <- function(x) {
  if (strptime(x$date, "%m/%d/%y") > Sys.time()) {
    file.rename(from = paste0("posts/", x$filename),
                to   = paste0("posts/_", x$filename))
  }
}

lapply(x, ignore_future)
