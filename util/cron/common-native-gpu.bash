CWD=$(cd $(dirname ${BASH_SOURCE[0]}) ; pwd)
source $CWD/common-slurm-gasnet-cray-cs.bash

# Use latest system LLVM, to use an earlier version uncomment and pass version
# number as a parameter to the script.
# source /cray/css/users/chapelu/setup_system_llvm.bash

export CHPL_LLVM=system
export CHPL_LOCALE_MODEL=gpu
export CHPL_TEST_GPU=true
export CHPL_NIGHTLY_TEST_DIRS="gpu/native/"
