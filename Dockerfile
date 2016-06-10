# Start with Ubuntu
FROM ubuntu:14.04

ARG LUA="LUA51"
ARG BRANCH="master"
ENV LUA_VERSION $LUA
ENV INSTALL_DIR /opt
ENV TORCH_SERVER http://raw.githubusercontent.com/torch/rocks/master/

RUN apt-get update
RUN apt-get install -y software-properties-common git

WORKDIR $INSTALL_DIR

# Useful for proxy blocking git protocol
RUN git config --global url."http://".insteadOf git://

RUN git clone http://github.com/torch/distro.git $INSTALL_DIR/torch --recursive
WORKDIR $INSTALL_DIR/torch
RUN ./install-deps
RUN TORCH_LUA_VERSION=$LUA ./install.sh

WORKDIR $INSTALL_DIR/

ENV PATH $INSTALL_DIR/torch/install/bin:$PATH

RUN luarocks install luafilesystem
RUN luarocks install luassert
RUN luarocks install penlight
RUN luarocks install mediator_lua
RUN luarocks install busted
RUN luarocks install luacov
RUN luarocks --from=$TORCH_SERVER install paths
RUN luarocks --from=$TORCH_SERVER install dok
RUN luarocks --from=$TORCH_SERVER install argcheck
RUN luarocks --from=$TORCH_SERVER install torch
RUN luarocks --from=$TORCH_SERVER install csvigo

RUN git clone http://github.com/AlexMili/torch-dataframe $INSTALL_DIR/torch-dataframe

WORKDIR $INSTALL_DIR/torch-dataframe

RUN git checkout $BRANCH
RUN luarocks make rocks/torch-dataframe-scm-1.rockspec CFLAGS="-O2 -fPIC -fprofile-arcs -ftest-coverage" LIBFLAG="-shared --coverage"

WORKDIR $INSTALL_DIR

CMD cd torch-dataframe
