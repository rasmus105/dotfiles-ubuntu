FROM ubuntu:26.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl git ca-certificates sudo && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


COPY . /home/dev/dotfiles
WORKDIR /home/dev/dotfiles

RUN chown -R dev:dev /home/dev/dotfiles

USER dev

RUN bash setup.sh
