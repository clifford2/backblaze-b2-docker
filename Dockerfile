FROM docker.io/library/python:3.13.0-alpine3.20

# Find latest release number at https://github.com/Backblaze/B2_Command_Line_Tool
ENV BACKBLAZE_B2_VERSION 4.2.0

RUN set -eux; \
	/usr/local/bin/python3 -m pip install --upgrade pip; \
	/usr/local/bin/pip3 install --no-cache-dir "b2 == $BACKBLAZE_B2_VERSION"

ENV HOME /home/b2
RUN umask 0;  test -d $HOME || mkdir $HOME

WORKDIR $HOME
ENTRYPOINT ["b2"]
CMD ["--help"]
