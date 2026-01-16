#!/usr/bin/env bash
set -euo pipefail

repo="gohugoio/hugo"
api="https://api.github.com/repos/${repo}/releases/latest"

asset_url="$(
  curl -fsSL "${api}" \
    | rg -o 'https://github.com/gohugoio/hugo/releases/download/[^"]+?/hugo_extended_[^"]+_linux-amd64.tar.gz' \
    | head -n 1
)"

if [[ -z "${asset_url}" ]]; then
  echo "hugo_extended linux tarball not found in latest release." >&2
  exit 1
fi

install_dir="${HOME}/.local/bin"
tmp_dir="$(mktemp -d)"
archive_path="${tmp_dir}/hugo_extended.tar.gz"

mkdir -p "${install_dir}"
curl -fsSL "${asset_url}" -o "${archive_path}"
tar -xzf "${archive_path}" -C "${tmp_dir}"

if [[ ! -f "${tmp_dir}/hugo" ]]; then
  echo "hugo binary not found after extraction." >&2
  exit 1
fi

install -m 0755 "${tmp_dir}/hugo" "${install_dir}/hugo"

if ! command -v hugo >/dev/null 2>&1; then
  export PATH="${install_dir}:${PATH}"
fi

hugo version
