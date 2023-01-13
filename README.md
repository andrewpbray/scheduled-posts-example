# Scheduled Posts Example

This is an example of a Quarto website featuring a blog listing on the Posts page linked in the navbar. The goal is to allow two versions of this website to be published: a full version of every `notes.qmd` file in Posts and a partial version showing only the `notes.qmd` files with dates in the past. 

[Full Version]()
[Partial Version]()

This repo shows two approaches, both of which store the dates for every post in `_schedule.yml`.

### Ignoring future posts

This approach seems like a functional solution for now. You can test it out locally by first sourcing the `ignore_future_docs.R` script, then running:

`quarto render --profile ignore-future`

What's happening:

1. The script, `ignore_future_docs.R`, adds a `_` to the start of the directory for any posts in the future. By the Render Targets feature of Quarto Projects, these files will be ignored during the rendering process.
2. It renders the remaining files into `_site-ignore-future`.
3. It runs a post-render script, `unignore_future_docs.R`, to undo the changes that we made to the paths of the future posts.

When running this as part of a GHA, as is done in this repo, step 3 isn't necessary since it's on a temporary machine that uploades only the rendered material to netlify.


### Edit Environmental Variable

This approach doesn't work, but it might still be instructive.

`quarto render --profile edit-env`

What's happening:

1. Quarto runs a config sequence that includes building the list of all files to render and storing it as `QUARTO_PROJECT_INPUT_FILES`.
2. Then it runs `edit_render_list.R` as a pre-render script, which gets that list, strips out files from the future, then re-sets the variable using the partial list.
3. Quarto then tries to render the original list of files, and errors out when it can't find the now-missing files.

This is described [here](https://github.com/quarto-dev/quarto-cli/discussions/3879).



