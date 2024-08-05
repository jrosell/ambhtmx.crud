---
title: Ambhtmx.crud
emoji: 🏃
colorFrom: pink
colorTo: pink
sdk: docker
pinned: false
---

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

<!-- badges: end -->

**THIS IS A WORK IN PROGRESS, DO NOT USE**

## Deployment options

### Hugging Face Spaces

When you push a repository to a Hugging Face Spaces with the option to deploy Dockerfile and include a Dockerfile,  Hugging Face will start building and running your app in the Space.

To avoid broser's cookies security restrictions, instead of using the version with iframes, better use the direct URL to your Space:

Try the demo here: 

* Direct URL to the deployed app: https://jrosell-ambhtmx-crud.hf.space/
* User: admin
* Password: demo
* Space URL: https://huggingface.co/spaces/jrosell/ambhtmx.crud



### Runing the example in Docker

You may need to set some environment variables in the .Renviron file:

```
GITHUB_PAT=<an optional token to install github repos safely>
AMBHTMX_USER=<your user>
AMBHTMX_PASSWORD=<your password>
AMBHTMX_SECRET=<a secret key to make cookies safer>
AMBHTMX_PROTOCOL=http
AMBHTMX_HOST=0.0.0.0
AMBHTMX_PORT=7860
````

Then, you can create the ambhtmx-image and run the ambhtmx-container in Docker:

If you have GNU Make installed in your Linux system, just run:

```
make
```

If you prefer, you can do it step by step.

1. Building the ambhtmx-image:

```
docker build -f Dockerfile -t ambhtmx-image .
```

2. Runing the ambhtmx-container:

```
docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx-image
```

3. Check the app on http://127.0.0.1:3000 or http://AMBHTMX_HOST:AMBHTMX_PORT :)

4. Stoping and removing the ambhtmx-container:

```
docker container rm -f ambhtmx-container
```

5. Removing the image
```
docker images 'ambhtmx-image' -a -q
docker rmi ID

## Troubleshooting

If you want to see the logs:

```
docker build -f Dockerfile  --no-cache --progress=plain -t ambhtmx-image . 2>&1 | tee build.log
```

Check the [known issues](https://github.com/jrosell/ambhtmx/issues), and if you have another issue? Please, [let me know](https://github.com/jrosell/ambhtmx/issues).