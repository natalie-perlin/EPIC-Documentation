#!/bin/bash
# Initialize Lmod:
export BASH_ENV=/usr/share/lmod/lmod/init/bash
source $BASH_ENV
#
set -x
URL="https://repo.anaconda.com/miniconda"
installer="Miniconda3-py39_4.12.0-Linux-x86_64.sh"
version="4.12.0"
[[ -f "$installer" ]] || wget -nv $URL/$installer
# The PREFIX below is the target installation, try local directory first
PREFIX0="/home/ubuntu/miniconda3"
PREFIX="${PREFIX0}/${version}"
[[ -d $PREFIX ]] && echo "Directory $PREFIX exists"
bash $installer -b -p $PREFIX -s
export CONDA_ROOT=$PREFIX
export CONDARC=$CONDA_ROOT/.condarc
export CONDA_ENVS_DIRS=$CONDA_ROOT/envs
export CONDA_PKGS_DIRS=$CONDA_ROOT/pkgs
echo "sourcing conda.sh"
PS1=
source $PREFIX/etc/profile.d/conda.sh
echo "disabling conda auto updates"
conda config --system --set auto_update_conda False
echo "install $version of miniconda3, installer = $installer"
conda install -yq conda=$version
# You may need to install ncurses from conda-forge
# to prevent warnings or errors about "no version information available"
# from Linux dynamic linker
conda install -c conda-forge -y ncurses
# This only installs base miniconda3 environment
# Need to create a module for miniconda3!!!
# Verify that the lua module template is present in $TEMPLATES
#  - miniconda3template.lua - needs to have a correct path for the prefix variable.
# Create a directory for the modulefiles, $MODULEFILES
# Copy and rename the template modulefile (miniconda3template.lua) to the new modulefile:
#   cp -v ${TEMPLATES}/miniconda3template.lua ${MODULEFILES}/miniconda3/{version}.lua
TEMPLATES=$PWD
MODULEFILES="${PREFIX0}/modulefiles"
[[ -d "${MODULEFILES}/miniconda3" ]] || mkdir -p ${MODULEFILES}/miniconda3/
[[ -f "${TEMPLATES}/miniconda3template.lua" ]] && cp -v ${TEMPLATES}/miniconda3template.lua  ${MODULEFILES}/miniconda3/${version}.lua
