OpenAI Triton Compiler with LLVM 21.1.0 / 21.1.1
============================

This is my fork of the OpenAI Triton Compiler v3.4.0 that has been verified to build correctly and work with LLVM 21.1.0 or LLVM 21.1.1, CUDA 12.9, AMD ROCm 6.4.3 and Python 3.13, on Fedora 41. It will likely work just as well on more recent Fedora versions. I cannot speak for earlier Fedora releases since I haven't tried.

The `main` branch in this repo contains the unmodified upstream Triton version 3.4.0. The fork described in this README is in the `triton-3.4.0-llvm-21.1.1-fc41` branch.

Triton will not build with LLVM 20.1.0 or LLVM 19.1.1. Several public MLIR interfaces that are imported by Triton are missing in those versions.

The original [README.md](https://github.com/steleman/openai-triton/blob/main/README.md) file has been renamed to  [TRITON.OPENAI.README.md](https://github.com/steleman/openai-triton/blob/triton-3.4.0-llvm-21.1.1-fc41/TRITON.OPENAI.README.md).

Build scripts are in the build_scripts directory.

Build instructions:
----------------------
1. Obtain a development build of LLVM either 21.1.0 or 21.1.1, including MLIR. By development build I mean: an LLVM installation that includes all the header files and libraries.
2. Clone this repository.
3. Copy the file `Makefile.configure-triton` to the cloned directory's parent directory. For example: if you cloned this repo into `/builds/triton-openai`, do: `cp /builds/triton-openai/build_scripts/Makefile.configure-triton /builds/`.
4. Run `gmake -f Makefile.configure-triton configure`. This will create a build directory under `/builds/build-triton`.
5. `cd /builds/build-triton`.
6. `cp ../triton-openai/build_scripts/build-triton.sh .`.
7. `cp ../triton-openai/build_scripts/install-triton.sh .`
8. Run the build script: `./build-triton.sh`.
9. When the build is finished you can install Triton with the `install_triton.sh` script by running `./install-triton.sh` from the same directory. This will install OpenAI Triton in a local \$DESTDIR.
10. If you want to build a Python Wheel, change to the toplevel cloned directory: `cd /builds/triton-openai` and do: `cp ./build_scripts/pip3-build-triton-wheel.sh .`.
11. Run the Wheel build script from the toplevel directory: `./pip3-build-triton-wheel.sh`.

This fork of Triton 3.4.0 has been patched to build and work with LLVM 21. The patch can be found in the `patches` toplevel directory. 

You can find and download pre-built rpms and the corresponding Triton Wheel at my Google Drive: 

https://drive.google.com/drive/folders/1kGQJ9xZk6GENUZVOPEMRynbXC3HnO2ED?usp=drive_link

These rpms install LLVM 21.1.1 and Triton 3.4.0 in `/opt/triton/llvm-21.1.1`.  You must install with `rpm`, and not `dnf`:
`%> rpm -i --force --nodeps ./llvm-triton-21.1.1-100.fc41.x86_64.rpm`
`%> rpm -i --force --nodeps ./triton-3.4.0+gitc817b9b6-500.fc41.x86_64.rpm`

The Python Wheel installs normally with `pip3`.

The rpm `python3-triton-3.4.0+gitc817b9b6-500.fc41.x86_64.rpm` contains the Python files for Triton packaged as an rpm. Its delivered contents are identical to the files delivered by the Triton Python Wheel.

Installing CUDA 12.9 and AMD ROCm 6.4.3 on Fedora 41+ is left as an exercise for the reader. :-)


