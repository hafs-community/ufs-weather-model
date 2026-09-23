help([[
loads UFS Model prerequisites for Wcoss3/Intel
]])

prepend_path("MODULEPATH", "/opt/intel/oneapi/mpi/2021.18/etc/modulefiles/mpi")
prepend_path("MODULEPATH", "/lfs/work/alexander_richert/stack/spack-stack/envs/nco-core-gcc-11.5.0/modules_flat/Core")
prepend_path("MODULEPATH", "/lfs/work/alexander_richert/stack/spack-stack/envs/nco-sci-intel-2021.10.0/modules_flat/Core")

cmake_ver=os.getenv("cmake_ver") or "3.31.11"
load(pathJoin("cmake", cmake_ver))

local ufs_modules = {

  {["python"]          = "3.11.15"},
  {["python-venv"]     = "1.0"},
  {["py-pyyaml"]       = "6.0.3"},
  {["libyaml"]          = "0.2.5"},
  {["jasper"]          = "4.2.8"},
  {["libpng"]          = "1.6.55"},
  {["hdf5"]            = "1.14.5"},
  {["netcdf-c"]        = "4.9.2"},
  {["netcdf-fortran"]  = "4.6.1"},
  {["parallelio"]      = "2.6.2"},
  {["esmf"]            = "8.8.0"},
  {["fms"]             = "2024.03-gfs-constants"},
  {["bacio"]           = "2.4.1"},
  {["crtm"]            = "2.4.0.1"},
  {["g2"]              = "3.5.1"},
  {["g2tmpl"]          = "1.17.0"},
  {["ip"]              = "5.4.0"},
  {["sp"]              = "2.5.0"},
  {["w3emc"]           = "2.13.0"},
  {["gftl-shared"]     = "1.12.0"},
  {["mapl"]            = "2.53.4-esmf-8.8.0"},
}

for i = 1, #ufs_modules do
  for name, default_version in pairs(ufs_modules[i]) do
    local env_version_name = string.gsub(name, "-", "_") .. "_ver"
    load(pathJoin(name, os.getenv(env_version_name) or default_version))
  end
end


nccmp_ver=os.getenv("nccmp_ver") or "1.9.1.0"
--load(pathJoin("nccmp", nccmp_ver))

scotch_ver=os.getenv("scotch_ver") or "7.0.7"
load(pathJoin("scotch", scotch_ver))

setenv("CC", "mpiicx")
setenv("CXX", "mpiicpx")
setenv("FC", "mpiifort")
setenv("I_MPI_CC", "icx")
setenv("I_MPI_CXX", "icpx")
setenv("I_MPI_F90", "ifort")

setenv("CMAKE_Platform", "wcoss2.intel")

whatis("Description: UFS build environment")
whatis("Description: UFS build environment common libraries")

