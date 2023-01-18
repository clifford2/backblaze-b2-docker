FROM docker.io/library/python:3.10-alpine

# Find latest release number at https://github.com/Backblaze/B2_Command_Line_Tool
ENV BACKBLAZE_B2_VERSION 3.6.0

RUN set -eux; \
	/usr/local/bin/python -m pip install --upgrade pip; \
	pip install --no-cache-dir "b2 == $BACKBLAZE_B2_VERSION"

ENV HOME /home/b2
RUN umask 0;  test -d $HOME || mkdir $HOME

WORKDIR $HOME
ENTRYPOINT ["b2"]
CMD ["--help"]
