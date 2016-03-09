define systemd::mask (
$ensure = 'link',
) {

  ::systemd::unit { "${name}":
    ensure  => $ensure,
    target  => '/dev/null',
  }

}
