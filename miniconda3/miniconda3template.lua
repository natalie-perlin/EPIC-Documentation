help([[
This module initializes and loads conda 
]])

local pkgName    = myModuleName()
local pkgVersion = myModuleVersion()
local pkgNameVer = myModuleFullName()
local shell=myShellType()
-- Uncomment a line below if myShellType() produces errors
-- local shell="sh"  

family("python")

conflict(pkgName)
conflict("python")
conflict("intelpython")

local prefix = pathJoin("/home/ubuntu/",pkgName)
local base = pathJoin(prefix,pkgVersion)
local conda_file=pathJoin(base,"etc", "profile.d", "conda." .. shell)
local command="source " .. conda_file

local mpath = pathJoin(prefix,"modulefiles")

setenv("CONDA_ROOT", base)
setenv("CONDA_EXE", pathJoin(base,"condabin"))
setenv("CONDA_ENVS_DIRS", pathJoin(base,"envs"))
setenv("CONDA_PKGS_DIRS", pathJoin(base,"pkgs"))
setenv("CONDARC",         pathJoin(base,".condarc"))

prepend_path("PATH",            pathJoin(base, "bin"))
prepend_path("PATH",            pathJoin(base, "condabin"))
prepend_path("LD_LIBRARY_PATH", pathJoin(base, "lib"))
prepend_path("MANPATH", pathJoin(base, "share", "man"))
prepend_path("MODULEPATH", mpath)

if mode() == "load" then
  execute{cmd=command, modeA={"load"}}
elseif mode() == "unload" then
  if shell == "csh" then
    execute{cmd="unalias conda", modeA={"unload"}}
  end
  remove_path("PATH", pathJoin(base, "condabin"))
  remove_path("PATH", pathJoin(base, "bin"))
  remove_path("MANPATH", pathJoin(base, "share", "man"))
end

whatis("Name: ".. pkgName)
whatis("Version: " .. pkgVersion)
whatis("Category: Python")
whatis("Description: Miniconda3 Family")

