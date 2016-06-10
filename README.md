# docker-torch-dataframe
Docker installation for torch-dataframe

# Build

You can build this image with the following arguments :
```bash
docker build --build-arg LUA=LUA51 --build-arg BRANCH=master -t docker-dataframe docker-torch-dataframe
```
or
```bash
docker build -t docker-dataframe docker-torch-dataframe
```

- **LUA** : Lua version to use for torch install. Possible values are LUA51, LUA52, LUA53, LUAJIT20 and LUAJIT21. Default value is LUA51
- **BRANCH** : torch-dataframe git branch to build. Default value is master

Then you can access to this image by running :

```bash
docker run -i -t docker-dataframe /bin/sh
```
