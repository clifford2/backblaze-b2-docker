#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2021 Clifford Weinmann <https://www.cliffordweinmann.com/>
#
# SPDX-License-Identifier: Unlicense

# Check for new version, and update version Dockerfile & README.md
# Alternate: find latest release number manually at https://github.com/Backblaze/B2_Command_Line_Tool

set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")/.."

source ./.env

current=$(awk '/^ENV BACKBLAZE_B2_VERSION/ {print $3}' Dockerfile)
latest=$(curl -fsSL 'https://pypi.org/pypi/b2/json' | jq -r .info.version)

echo $B2CLI_VERSION $latest

if [ "$latest" == "$B2CLI_VERSION" ]
then
	echo "Version unchanged ($B2CLI_VERSION)"
else
	echo "New version available - upgrading from $B2CLI_VERSION to $latest"
	set -x
	sed -Ei 's/^(ENV BACKBLAZE_B2_VERSION) .*/\1 '"$latest"'/' Dockerfile
	sed -Ei 's|^(B2CLI_VERSION=).*$|\1'"'${latest}'|" .env
	sed -i -e "s|cliffordw/backblaze-b2:[^ ]*|cliffordw/backblaze-b2:${latest}-${RELEASE_VERSION}|" -e "s|^- B2 CLI version: .*$|- B2 CLI version: ${latest}|" -e "s|^- Container build version: .*$|- Container build version: ${RELEASE_VERSION}|" README.md
fi
