# [mpd](https://galaxy.ansible.com/kso512/mpd/)

[![Release](https://github.com/kso512/mpd/actions/workflows/release.yml/badge.svg)](https://github.com/kso512/mpd/actions/workflows/release.yml) [![GitHub issues](https://img.shields.io/github/issues-raw/kso512/mpd)](https://github.com/kso512/mpd) [![GitHub repo size](https://img.shields.io/github/repo-size/kso512/mpd)](https://github.com/kso512/mpd)

[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/) [![made-with-Markdown](https://img.shields.io/badge/Made%20with-Markdown-1f425f.svg)](http://commonmark.org) [![GitHub](https://img.shields.io/github/license/kso512/mpd)](https://www.gnu.org/licenses/gpl-2.0.txt)

An [Ansible](https://www.ansible.com/) [Role](http://docs.ansible.com/ansible/playbooks_roles.html#roles) to install the [Music Player Daemon](http://www.musicpd.org/) application from source instead of via a package manager.  Some package managers may not include features such as MP3 support, so compiling from the source code may help.

This is a complete rebuild of the [ansible-install-mpd](https://github.com/kso512/ansible-install-mpd) role I created and maintained for years, undertaken due to changes in CI/CD and naming conventions in Ansible Galaxy.

**I do not recommend the default configuration for unprotected connection directly to the Internet, as the server configuration includes access without a password.**  Instead, I recommend the operator increase security by configuring a host or group variable that overrides `mpd_conf_src` with a custom file from outside the repository, as shown in the [Example Playbook](https://github.com/kso512/mpd#example-playbook) section below.

All tasks are tagged with `mpd`.

The following distributions have been tested automatically:

- [Debian 12 "Bookworm"](https://www.debian.org/releases/bookworm/)

## Version Matrix

| Role Version/Tag | MPD Version |
|------------------|-------------|
| 1.0.21           | [0.23.17](https://www.musicpd.org/news/2025/01/mpd-0-23-17-released/) |
| 1.0.20           | [0.23.16](https://www.musicpd.org/news/2024/12/mpd-0-23-16-released/) |
| 1.0.19           | [0.23.15](https://www.musicpd.org/news/2023/12/mpd-0-23-15-released/) |
| 1.0.18           | [0.23.14](https://www.musicpd.org/news/2023/10/mpd-0-23-14-released/) |
| 1.0.16 - 1.0.17  | [0.23.13](https://www.musicpd.org/news/2023/05/mpd-0-23-13-released/) |

## Requirements

If the server has a firewall enabled, it may need alteration to allow incoming packets on TCP ports 6600/8000.  The role includes no music or playlists, so you'll need to supply those.  See the [Role Variables](https://github.com/kso512/mpd#role-variables) section below for those locations.

## Role Variables

The default values shown below should work "out-of-the-box" and only need customization if they don't meet your needs.

| Name | Description | Default Value |
| ---- | ----------- | ------------- |
| mpd_apt_prereqs | List of APT packages to install | (See [NOTE A](https://github.com/kso512/mpd#note-a) below) |
| mpd_audio_output | Dictionary containing audio output definitions | (See [NOTE B](https://github.com/kso512/mpd#note-b) below) |
| mpd_bind_to_address | Address to bind the control interface to; examples are "any" or "localhost" | `"any"` |
| mpd_comment | Comment for the MPD user | `"Music Player Daemon"` |
| mpd_compile_creates | Full path name of the file created when compiling MPD | `"{{ mpd_src }}/output/release/mpd"` |
| mpd_conf | Full path name of the MPD configuration file | `"{{ mpd_home }}/mpd.conf"` |
| mpd_conf_mode | File mode settings of the MPD configuration file | `"0644"` |
| mpd_conf_src | Relative or full path name of the MPD configuration file source | `mpd.conf.j2` |
| mpd_configure_creates | Full path name of the file created when configuring the source of MPD | `"{{ mpd_src }}/output/release/build.ninja"` |
| mpd_database_plugin | Type of database plugin to use; see [Database plugins](https://mpd.readthedocs.io/en/stable/plugins.html#database-plugins) for options. | `"simple"` |
| mpd_database_path | Full path name of the MPD database file | `"{{ mpd_home }}/tag_cache"` |
| mpd_database_cache_directory | The path of the cache directory for additional storages mounted at runtime | `"{{ mpd_home }}/cache"` |
| mpd_executable | Full path name of the MPD executable | `"/usr/local/bin/mpd"` |
| mpd_filename | File name of the MPD archive | `"{{ mpd_shortname }}.tar.xz"` |
| mpd_group | Group of the user that will own the daemon process | `"{{ mpd_user }}"` |
| mpd_home | Main directory for the application to run in | `"/home/{{ mpd_user }}"` |
| mpd_log_file | Full path name of the MPD log file | `"{{ mpd_home }}/log"` |
| mpd_metadata_to_use | Use only the specified comma-separated tags, and ignore the others; see [Tags](https://mpd.readthedocs.io/en/stable/protocol.html#tags) for a list of supported tags | `"AlbumArtist,Artist,Album,Title,Track,Disc,Genre,Name"` |
| mpd_mode | File mode settings of the MPD source, music, and playlist folders | `"0755"` |
| mpd_music_directory | Folder to store music in | `"{{ mpd_home }}/music"` |
| mpd_neighbors | List of neighbor plugins to enable | (See [NOTE C](https://github.com/kso512/mpd#note-c) below) |
| mpd_pid_file | Full path name of the MPD PID file | `"{{ mpd_home }}/pid"` |
| mpd_pip_prereqs | List of PIP packages to install | `"meson>0.56.0"` |
| mpd_playlist_directory | Folder to store playlists in | `"{{ mpd_home }}/playlist"` |
| mpd_port | TCP port to bind the control interface to | `"6600"` |
| mpd_ratings_file | Full path name of the MPD ratings file | `"{{ mpd_home }}/ratings.db"` |
| mpd_shortname | Short name of the MPD archive | `"mpd-0.23.17"` |
| mpd_src | Directory to unarchive the source code in | `"{{ mpd_src_base }}/{{ mpd_shortname }}"` |
| mpd_src_base | Directory to place the source code archive in | `"{{ mpd_home }}/src"` |
| mpd_state_file | Full path name of the MPD state file | `"{{ mpd_home }}/state"` |
| mpd_sticker_file | Full path name of the MPD sticker file | `"{{ mpd_home }}/sticker.sql"` |
| mpd_systemd_service_dest | Full path name of the MPD systemd service unit file | `"/etc/systemd/system/mpd.service"` |
| mpd_systemd_service_group | Group of the user that will own the systemd unit file | `"root"` |
| mpd_systemd_service_owner | Name of the user that will own the systemd unit file | `"root"` |
| mpd_systemd_service_mode | File mode settings of the systemd unit file | `"0644"` |
| mpd_systemd_service_src | Relative or full path name of the MPD systemd service unit file source | `"systemd.mpd.service.j2"` |
| mpd_url | Full URL to download the source code archive | `"{{ mpd_url_base }}/{{ mpd_filename }}"` |
| mpd_url_base | Base of the URL to download the source code archive | `"http://www.musicpd.org/download/mpd/0.23"` |
| mpd_user | Name of the user that will own the daemon process | `"mpd"` |

### NOTE A

`mpd_apt_prereqs` - List of APT packages to install:

- meson
- g++
- libfmt-dev
- libpcre2-dev
- libmad0-dev
- libmpg123-dev
- libid3tag0-dev
- libflac-dev
- libvorbis-dev
- libopus-dev
- libogg-dev
- libadplug-dev
- libaudiofile-dev
- libsndfile1-dev
- libfaad-dev
- libfluidsynth-dev
- libgme-dev
- libmikmod-dev
- libmodplug-dev
- libmpcdec-dev
- libwavpack-dev
- libwildmidi-dev
- libsidplay2-dev
- libsidutils-dev
- libresid-builder-dev
- libavcodec-dev
- libavformat-dev
- libmp3lame-dev
- libtwolame-dev
- libshine-dev
- libsamplerate0-dev
- libsoxr-dev
- libbz2-dev
- libcdio-paranoia-dev
- libiso9660-dev
- libmms-dev
- libzzip-dev
- libcurl4-gnutls-dev
- libyajl-dev
- libexpat1-dev
- libasound2-dev
- libao-dev
- libjack-jackd2-dev
- libopenal-dev
- libpulse-dev
- libshout3-dev
- libsndio-dev
- libmpdclient-dev
- libnfs-dev
- libupnp-dev
- libavahi-client-dev
- libsqlite3-dev
- libsystemd-dev
- libgtest-dev
- libicu-dev
- libchromaprint-dev
- libgcrypt20-dev
- libpipewire-0.3-dev

### NOTE B

`mpd_audio_output` - Dictionary containing audio output definitions:

    httpd:
      type: httpd
      name: My HTTP Stream
      encoder: lame
      port: 8000
      bitrate: 128
      format: "44100:16:2"
      always_on: "yes"
      tags: "yes"

### NOTE C

`mpd_neighbors` - List of neighbor plugins to enable; see [Configuring Neighbor Plugins](https://mpd.readthedocs.io/en/stable/user.html#configuring-neighbor-plugins) for more information.

- udisks
- upnp

## Dependencies

None yet defined.

## Example Playbook

Configure each MPD server with a customized local mpd.conf:

    - hosts: music-servers
      roles:
        - { role: kso512.mpd, mpd_conf_src: local/mpd.conf.j2 }

## License

[GNU General Public License version 2](https://www.gnu.org/licenses/gpl-2.0.txt)

## Author Information

[@kso512](https://github.com/kso512)
