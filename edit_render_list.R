# Reader in full render list
render_list <- Sys.getenv("QUARTO_PROJECT_INPUT_FILES")
render_list <- "posts/topic-3/notes.qmd\nposts/topic-2/notes.qmd\nposts/topic-1/notes.qmd\nindex.qmd\nposts.qmd"
render_list <- unlist(strsplit(render_list, "\n"))

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
partial_render_list <- setdiff(render_list, future_docs)
Sys.setenv("QUARTO_PROJECT_INPUT_FILES" = paste(partial_render_list, collapse = "\n"))

# Print to help debug
Sys.getenv("QUARTO_PROJECT_INPUT_FILES")
