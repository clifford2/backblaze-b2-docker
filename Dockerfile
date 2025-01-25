# SPDX-FileCopyrightText: © 2021 Clifford Weinmann <https://www.cliffordweinmann.com/>
#
# SPDX-License-Identifier: Unlicense

FROM docker.io/library/python:3.13.1-alpine3.21

# Find latest release number at https://github.com/Backblaze/B2_Command_Line_Tool
ENV BACKBLAZE_B2_VERSION 4.3.0

RUN set -eux; \
	/usr/local/bin/python3 -m pip install --upgrade pip; \
	/usr/local/bin/pip3 install --no-cache-dir "b2 == $BACKBLAZE_B2_VERSION"

ENV HOME /home/b2
RUN umask 0;  test -d $HOME || mkdir $HOME

WORKDIR $HOME
ENTRYPOINT ["b2"]
CMD ["--help"]
