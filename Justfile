CONTAINER_ARGS :=  '--rm -d --name=techdiary \
	--publish 4000:4000 --publish 35942:35942 \
	--env JEKYLL_LOG_LEVEL=debug \
	--env TZ=Asia/Kolkata'

IMAGE := 'ghcr.io/github/pages-gem:v232'

JEKYLL_CMD := 'jekyll serve'
JEKYLL_ARGS := '--host 0.0.0.0 --port 4000 --livereload-port 35942 \
	      --livereload \
	      --future --drafts --baseurl /'

CONTAINER_CMD := f"{{IMAGE}} {{JEKYLL_CMD}} {{JEKYLL_ARGS}}"

pod:
	podman run {{CONTAINER_ARGS}} -v ./:/src/site:z {{CONTAINER_CMD}}

build:
	podman run {{CONTAINER_ARGS}} -v ./:/src/site:z {{IMAGE}} \
			jekyll build
