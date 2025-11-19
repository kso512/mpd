#!/usr/bin/env bash

# List of supported distros
distros=( debian12 debian13 )
#distros=( debian12 )

# Fail upon any error
set -e

# Loop through the list of distros
for distro in ${distros[@]}; do

  # Run the docker container, which outputs the unique id of the container
  echo ""
  echo "=00= Running container for distro: ${distro}"
  container=$(docker run --detach --privileged \
    --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host \
    --volume=$(pwd):/etc/ansible/roles/role_under_test:ro \
    "geerlingguy/docker-${distro}-ansible:latest")

  # Run the ansible playbook and look for no failures
  echo "-01- Testing playbook for no failures in distro: ${distro}"
  ansible_output=$(docker exec --tty "${container}" env TERM=xterm \
    ansible-playbook /etc/ansible/roles/role_under_test/test/playbook.yml)
  echo "${ansible_output}" | \
    grep -o "failed=0"

  # Run the ansible playbook again and look for idempotence
  echo "-02- Testing playbook for no changes (idempotence) in distro: ${distro}"
  ansible_output=$(docker exec --tty "${container}" env TERM=xterm \
    ansible-playbook /etc/ansible/roles/role_under_test/test/playbook.yml)
  echo "${ansible_output}" | \
    grep -o "changed=0"

  # Make sure the daemon runs
  echo "-03- Testing MPD runs in distro: $distro"
  agent_output=$(docker exec --tty $container env TERM=xterm \
    mpd --version)
  echo "${agent_output}" | \
    head -n 1 | \
    grep --max-count 1 "Music Player Daemon"

  # Remove the container once the test passes
  echo "-04- Removing container for distro: ${distro}"
  docker rm -f "${container}"

  # End 'for distro' loop
  done

# Finish clean
exit 0
