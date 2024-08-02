---
title: Ambhtmx.crud
emoji: 🏃
colorFrom: pink
colorTo: pink
sdk: docker
pinned: false
---

Check out the configuration reference at https://huggingface.co/docs/hub/spaces-config-reference


# Docker in local

To create the image and run the container in Docker, run:

```
docker build -f Dockerfile -t ambhtmx . \
  && docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx
```

If you need an output folder:
```
docker build -f Dockerfile -t ambhtmx . \
  && docker run -env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm  -v $(pwd)/output:/workspace/output/:rw  ambhtmx
```


To stop, remove the container and create the image and run another container:
```
docker container rm -f ambhtmx-container \
  && docker build -f Dockerfile -t ambhtmx . \
  && docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx
```


