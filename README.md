# torrent-preview.yazi

[Yazi](https://github.com/sxyazi/yazi) plugin to preview `application/x-bittorrent` files

## Requirements

- `yazi`
- [transmission-cli](https://github.com/transmission/transmission)

## Installation

### Linux/MacOS

```sh
git clone https://github.com/kirasok/torrent-preview.yazi.git ~/.config/yazi/plugins/torrent-preview.yazi
```

## Usage

Add this to your `yazi.toml`:

```toml
[[plugin.prepend_previewers]]
mime = "application/x-bittorrent"
run = "torrent-preview"
```
