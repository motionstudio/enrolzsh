# Vagrant Command
#

enrol.vu() { cd $ER_VM_DIR && vagrant up }
enrol.vh() { cd $ER_VM_DIR && vagrant halt }
enrol.vr() { cd $ER_VM_DIR && vagrant reload }
enrol.vs() { cd $ER_VM_DIR && vagrant ssh }
enrol.vb() { cd $ER_VM_DIR && vagrant box update }