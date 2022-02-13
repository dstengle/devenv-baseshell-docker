# dev-shell-docker
Docker image for (my) personal developer shell

Contains basic utils and zsh with antigen

To build:
```
docker build --rm -f Dockerfile -t devenv-baseshell:latest .
```

Create a home directory volume
```
docker volume create home_dir
```

Then run:
```
docker run -v home_dir:/home/devuser  -it devenv-baseshell:latest /bin/zsh
```