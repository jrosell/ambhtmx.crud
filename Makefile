# This is an optional file, but if you have Make installed in your sytem,
# an configured in your terminal path, just run the `make` command line.
# This will stop the ambhtmx-container, remove the ambhtmx-image, recreate the ambhtmx-image and run the ambhtmx-container
all:
	(docker container rm -f ambhtmx-container || true)\
		&& (docker rmi $(docker images --format '{{.Repository}}:{{.ID}}'| egrep 'ambhtmx-image' | cut -d':' -f2 | uniq) --force || true) \
		&& docker build -f Dockerfile -t ambhtmx-image . \
		&& docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx-image  \
		&& echo "Done"

clean:
	(docker container rm -f ambhtmx-container || true)\
		&& (docker rmi $(docker images --format '{{.Repository}}:{{.ID}}'| egrep 'ambhtmx-image' | cut -d':' -f2 | uniq) --force || true) \
		&& echo "Done"

build:
	docker build -f Dockerfile --no-cache --progress=plain -t ambhtmx-image . 2>&1 | tee build.log

run:
	docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx-image

secrets:
	docker build --secret id=GITHUB_PAT,src=/run/secrets/GITHUB_PAT -f Dockerfile -t ambhtmx-image .  \
		&& docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx-image 