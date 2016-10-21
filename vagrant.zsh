# Vagrant Command
#

enrol.vu() { eval cd $ER_VM_DIR && vagrant up }
enrol.vh() { eval cd $ER_VM_DIR && vagrant halt }
enrol.vr() { eval cd $ER_VM_DIR && vagrant reload }
enrol.vs() { eval cd $ER_VM_DIR && vagrant ssh }
enrol.vb() { eval cd $ER_VM_DIR && vagrant box update }