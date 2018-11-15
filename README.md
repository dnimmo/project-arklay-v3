# Development

Pre-requisite: Elm 0.19 (https://guide.elm-lang.org/install.html)

To build the app, you need to compile src/Main.elm to public/arklay.js. Do this with:

```elm make src/Main.elm --output=public/arklay.js```

For development, you'll probably want to add the `--debug` flag, but if you're finished development and want to upload, use `--optimize`.

For a live-reload environment, you can use elm-live. Install it globally with npm install -g elm-live, and then start it with ```elm-live --dir public -- src/Main.elm --output=public/arklay.js --debug```
