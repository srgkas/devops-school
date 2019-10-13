1. Build a basic image: `docker build . -t devops_school:3.1-base`
2. Create an temporary directory which will be used as volume: `mkdir /tmp/devops-school-tmp`
3. Run 
```
docker run -it \
    --rm \
    --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /tmp/devops-school-tmp:/var/devops_school_directory \
    --user $(id -u) \
    devops_school:3.1-base
```
4. Inside the container run: 
```
docker run --rm \
    -v /tmp/devops-school-tmp:/var/mega_directory \
    --user $(id -u) \
    alpine:3.10 sleep 1000
```
The point is you need to use the host machine folder path as the volume source because of the shared docker socket. 
