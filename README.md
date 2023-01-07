# Scheduled Posts Example

This is an example of a Quarto website featuring a blog listing on the Posts page linked in the navbar. The goal is to allow two versions of this website to be published: a full version of every `notes.qmd` file in Posts and a partial version showing only the `notes.qmd` files with dates in the past. This repo shows two approaches, both of which store the dates for every post in `_schedule.yml`.


### Edit Environmental Variable

This approach can be seen by running the follow at the terminal.

`quarto render --profile edit-env`

What's happening:

1. Quarto runs a config sequence that includes building the list of all files to render and storing it as `QUARTO_PROJECT_INPUT_FILES`.
2. Then it runs `edit_render_list.R`, which gets that list, strips out files from the future, then re-sets the variable using the partial list.
3. Rendering the partial list of files into `_site-edit-env`.

### Ignoring future posts

This approach does not work, but it might be instructive to see why not by running,

`quarto render --profile ignore-future`

What's happening:

1. It runs a pre-render script, `ignore_future_docs.R`, to add a `_` to the start of the directory for any posts in the future. By the Render Targets feature of Quarto Projects, these files will be ignored during the rendering process.
2. It renders the files into `_site-ignore-future`.
3. It runs a post-render script, `unignore_future_docs.R`, to undo the changes that we made to the paths of the future posts.

You'll notice that it errors out because it cannot find the original path to the future post. The reason for this is when `quarto render` is run, it does some config operations *before* running the pre-render script that includes building a list of all of the files to render. This list is stored in the environmental variable called `QUARTO_PROJECT_INPUT_FILES`. After running the script, it tries to render the files at their original paths, where they no longer exist.

This motivated the first approach that edits the environmental variable directly.

