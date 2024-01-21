# using puppet, install flask from pip3
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['python3-pip'],  # Ensure pip3 is installed first
}

# Install python3-pip package (if not already installed)
package { 'python3-pip':
  ensure => present,
}
