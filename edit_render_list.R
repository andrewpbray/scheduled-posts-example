# Reader in full render list
full_render_list <- Sys.getenv("QUARTO_PROJECT_INPUT_FILES")

# Print for debugging
full_render_list

full_render_list <- unlist(strsplit(full_render_list, "\n"))

# Read in schedule data
x <- yaml::read_yaml("_schedule.yml")

# Identify docs in the future
is_future_doc <- function(x) {
  if (strptime(x$date, "%m/%d/%y") > Sys.time()) {
    paste0("posts/", x$filename, "/notes.qmd")
  }
}

future_docs <- unlist(lapply(x, is_future_doc))

# Remove future docs from render list and set variable
partial_render_list <- paste(setdiff(full_render_list, future_docs), collapse = "\n")
Sys.setenv("QUARTO_PROJECT_INPUT_FILES" = partial_render_list)
# write(paste(partial_render_list, collapse = "\n"), "render_list.file")

# Print to help debug
partial_render_list
