---
title: Ambhtmx.crud
emoji: 🏃
colorFrom: pink
colorTo: pink
sdk: docker
pinned: false
---

Check out the configuration reference at https://huggingface.co/docs/hub/spaces-config-reference


# Runing the example in Docker

First, you can create the image and test the container in Docker:

```
docker build -f Dockerfile -t ambhtmx . \
  && docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx
```

If you want to rerun the process, you may need to remove the previous containers and images:

```
(docker container rm -f ambhtmx-container || true)\
  && (docker rmi $(docker images --format '{{.Repository}}:{{.ID}}'| egrep 'ambhtmx' | cut -d':' -f2 | uniq) --force || true) \
  && docker build -f Dockerfile -t ambhtmx . \
  && docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm ambhtmx
```


If you need to read the output files from your host, run:

```
docker build -f Dockerfile -t ambhtmx . \
  && docker run --env-file=.Renviron -p 7860:7860 --name ambhtmx-container --rm -v $(pwd)/output:/workspace/output/:rw ambhtmx
```



