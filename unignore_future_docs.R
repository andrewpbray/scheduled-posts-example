x <- yaml::read_yaml("_schedule.yml")

unignore_future <- function(x) {
  if (strptime(x$date, "%m/%d/%y") > Sys.time()) {
    file.rename(from = paste0("posts/_", x$filename),
                to   = paste0("posts/", x$filename))
  }
}

lapply(x, unignore_future)
