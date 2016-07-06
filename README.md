# network

**NTTCom-MS/eyp-network**: [![Build Status](https://travis-ci.org/NTTCom-MS/eyp-network.png?branch=master)](https://travis-ci.org/NTTCom-MS/eyp-network)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What network affects](#what-network-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with network](#beginning-with-network)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [Contributing](#contributing)

## Overview

Manages network configuration

## Module Description

Manages:
* Interfaces configuration
* routes configuration

## Setup

### What network affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements

This module requires pluginsync enabled and eyp/nsswitch module installed

### Beginning with network

```puppet
network::interface { 'eth0':
  dhcp => true,
  preup => 'sleep 2',
}

network::interface { 'eth1':
  ip => '192.168.56.18',
  netmask => '255.255.255.0',
}
```

```puppet
network::route { '1.1.1.0/24':
  eth=>'eth0',
  gw=>'10.0.2.2',
}

network::route { '1.2.3.0/24':
  eth=>'eth0',
  gw=>'10.0.2.2',
}
```

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

Tested on CentOS 6 and Ubuntu 14.04

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
