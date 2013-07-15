#!/usr/bin/env bats
# vi: set ft=sh :

@test "the DRb script exists" {
  [ -f /home/vagrant/drb-server.rb ]
}

@test "the DRb script is executable" {
  [ -x /home/vagrant/drb-server.rb ]
}
