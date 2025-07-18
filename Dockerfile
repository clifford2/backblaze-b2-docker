# SPDX-FileCopyrightText: © 2021 Clifford Weinmann <https://www.cliffordweinmann.com/>
#
# SPDX-License-Identifier: Unlicense

FROM docker.io/library/python:3.13.5-alpine3.22

# Check for updates with `build/update.sh`
ENV BACKBLAZE_B2_VERSION 4.3.3

LABEL maintainer="Clifford Weinmann <https://www.cliffordweinmann.com/>"
LABEL org.opencontainers.image.source https://github.com/clifford2/backblaze-b2-docker

RUN set -eux; \
	/usr/local/bin/python3 -m pip install --upgrade pip; \
	/usr/local/bin/pip3 install --no-cache-dir "b2 == $BACKBLAZE_B2_VERSION"

ENV HOME /home/b2
RUN umask 0;  test -d $HOME || mkdir $HOME
WORKDIR $HOME

ENTRYPOINT ["/usr/local/bin/b2"]
CMD ["--help"]
