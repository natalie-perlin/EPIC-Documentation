#!/bin/bash
# Initialize Lmod:
export BASH_ENV=/usr/share/lmod/lmod/init/bash
source $BASH_ENV
#
PREFIX0="/home/ubuntu/miniconda3"
version="4.12.0"
MODULEFILES="${PREFIX0}/modulefiles"
module use $MODULEFILES
module avail miniconda3
module load  miniconda3/$version
#
# Create and install regional_workflow environment
conda env list
py_version=$(python --version | awk -F" " '{print$2}')
echo "Python version to use for the regional_workflow is ${py_version}"
conda create --name regional_workflow -y python=${py_version}
# Enter 'y' in the interactive mode to proceed with the installation, or give '-y' option above
# to create environment under the miniconda3 installation directory:
# $PREFIX/envs/regional_workflow
#
conda activate regional_workflow
conda list # verify it is an empty environment
#
# install packages for the SRW (ufs-srweather-app)
conda install -c conda-forge -y f90nml
conda install -y jinja2
conda install -y pyyaml
# install packages for graphics environment
conda install -y scipy
conda install -y matplotlib
#conda install pygrib
conda install -c conda-forge -y pygrib
conda install -y cartopy
# You may need to install ncurses from conda-forge
# to prevent warnings or errors about "no version information available"  
# from Linux dynamic linker
conda install -c conda-forge -y ncurses
#
conda list
env_recipes="${PREFIX0}/environments"
[[ -d "$env_recipes" ]] || mkdir -p $env_recipes
conda list --export > $env_recipes/regional_workflow.txt
conda list --explicit > $env_recipes/regional_workflow.explicit.txt
conda env export > $env_recipes/regional_workflow.yml
#
conda deactivate
echo "Installed the packages for regional_worklow environment!"
exit 0
