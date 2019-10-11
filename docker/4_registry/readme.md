## Steps

1. Run `docker run -d -p 5000:5000 --restart=always --name registry registry:2`
2. Create `Dockerfile`
3. Build image: `docker build . -t localhost:5000/devops_school:3.4-sample`.
_Note_: image name should be prefixed with `localhost:5000`, which means this image will be hosted on localhost registry, port 5000, created in step 1.
4. Push image to the registry: `docker push localhost:5000/devops_school:3.4-sample`
5. Check the registry contains image:
   - remove local image: `docker rm -f localhost:5000/devops_school:3.4-sample`
   - pull image from registry: `docker pull localhost:5000/devops_school:3.4-sample`
