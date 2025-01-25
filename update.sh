#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2021 Clifford Weinmann <https://www.cliffordweinmann.com/>
#
# SPDX-License-Identifier: BSD-2-Clause

# Update version number in Dockerfile

set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

current="$(curl -fsSL 'https://pypi.org/pypi/b2/json' | jq -r .info.version)"

set -x
sed -ri 's/^(ENV BACKBLAZE_B2_VERSION) .*/\1 '"$current"'/' Dockerfile
sed -i -e "s|cliffordw/backblaze-b2:[^ ]*|cliffordw/backblaze-b2:${current}|" README.md
