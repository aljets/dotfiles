# Way, way faster Vagrant SSH. Run vagrant ssh-config to find private key location.
set vagrant_private_key '~/.vagrant.d/boxes/base/0/virtualbox/vagrant_private_key'
function vs
    ssh -Y -i $vagrant_private_key -p 2222 vagrant@127.0.0.1
end
