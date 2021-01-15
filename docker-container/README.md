# Doing your work from a container

Working in a container is an excellent option that is highly recommended.

- You don't need to install a lot of software on your local machine. - You are able to keep a good separation of your projects.
- It makes it very easy to clean up when you are done.

Following the guidelines below you could either create the docker image based on the dokerfile in this folder or you could download the image directly from docker hub.

## Option 1

Simply start the container with the command below (this will download the pre-built image from Docker hub).
```
# Create the image from the dockerfile in this folder. 
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host akata72/theazurelabimage:latest bash
```

## Option 2

...alternatively you can build the image yourselves and then start the container based on that image (you will then know exactly what is in the image).

```
# Create the image from the dockerfile 
docker build -t theazurelabimage:1.0 . 
```

```
# Start the container from the local image
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host theazurelabimage:1.0 bash
```

You are now ready to get started will all the modules and labs in this series.
