x <- yaml::read_yaml("_schedule.yml")

ignore_future <- function(x) {
  if (strptime(x$date, "%m/%d/%y") > Sys.time()) {
    file.rename(from = paste0("posts/", x$filename),
                to   = paste0("posts/_", x$filename))
  }
}

lapply(x, ignore_future)
