#!/usr/bin/env bats
# vi: set ft=sh :

@test "the DRb server is running" {
  ps aux | grep [d]rb-server
}
