# Parameters normally come from hiera.
# See the README

class {basichost:
       resolv_conf => {'domain'=>'domain.tld','search'=>'domain.tls sub.domain.tld','nameservers'=>['1.2.3.4','5.6.7.8']},
       directories => ['/home','/home/staff'],
       static_address => {'eth0'=>true},
       packages => ['zsh', 'tmux']
       }
