# Installation of Miniconda3 and regional_workflow environment

Last revision: December 5, 2022  (update as needed) @natalie-perlin 

1. Find a right installer script to download from **URL="https://repo.anaconda.com/miniconda"**, or determine its correct name, e.g., `Miniconda3-py39_4.12.0-Linux-x86_64.sh`

2. Configure the installation script **miniconda3_install.sh** as follows:

   a) BASH_ENV  - Lmod initialization script to be sourced, e.g.,
                `BASH_ENV=/usr/share/lmod/lmod/init/bash`
                
                
   b) installer - installer name to use or download from the URL (as in step 1).
   
          e.g., `installer="Miniconda3-py39_4.12.0-Linux-x86_64.sh"`
          
   c) version   - miniconda3 version
          e.g., `version="4.12.0"`
          
   d) PREFIX0  - a local installation path of the miniconda3, for all versions;
      PREFIX   - a local installation path for a particular version, e.g.,
                `PREFIX0="/contrib/EPIC/miniconda3"`, 
                `PREFIX="${PREFIX0}/${version}"`
                
   e) verify paths where the **miniconda3template.lua** template modulefile is located, and the required location of the functional miniconda3 modulefile, for the template to be copied to, e.g.,
               `TEMPLATES=$PWD`
               `MODULEFILES="$PREFIX0/modulefiles"`

3. Configure the modulefile *miniconda3template.lua* and specify local prefix, e.g.,
       `local prefix = pathJoin("/contrib/EPIC",pkgName)`

4. Run the installation script wrapper: 
   `./miniconda3_install.sh 2>&1 | tee log.miniconda3base_install`
   
5. To install additional packages for the base conda (e.g., git-lfs), configure a script 
   **miniconda3_install_plus.sh** and set variables needed as in Step 2, then run it:   
   `./miniconda3_install_plus.sh 2>&1 | tee log.miniconda3plus_install`
   
6. Create a regional_workflow environment with the packages needed to run the UFS-SRW App, 
   and to use graphic packages for plotting. Configure the env. varialbles similar to Step 2,
   and then launch the script **miniconda3_regional_workflow_new.sh**:   
   `./miniconda3_regional_workflow_new.sh 2>&1 | tee log.regional_workflow_install`
