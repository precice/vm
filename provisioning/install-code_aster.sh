#!/usr/bin/env bash
set -ex

# Install dependencies
sudo apt-get install -y bison cmake make flex g++ gcc gfortran \
    grace liblapack-dev libblas-dev \
    libboost-numpy-dev libboost-python-dev \
    python3 python3-dev python3-numpy \
    tk zlib1g-dev

# Install code_aster 14.6 - skip to save time if target dir exists
if [ ! -d "code_aster/" ]; then
    wget --quiet https://www.code-aster.org/FICHIERS/aster-full-src-14.6.0-1.noarch.tar.gz
    tar xvzf aster-full-src-14.6.0-1.noarch.tar.gz && rm -fv aster-full-src-14.6.0-1.noarch.tar.gz
    (
        cd aster-full-src-14.6.0
        yes | python3 setup.py install --prefix="${HOME}/code_aster"
    )
    echo ". ${HOME}/code_aster/etc/codeaster/profile.sh" >>~/.bashrc
    rm -rf ./aster-full-src-14.6.0/
fi

# Get the code_aster-preCICE adapter
if [ ! -d "code_aster-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/code_aster-adapter.git
fi
(
    cd "${HOME}/code_aster/14.6/lib/aster/Execution"
    ln -sf "${HOME}/code_aster-adapter/cht/adapter.py" .
)

# Remove the code_aster tests to save space (approx. 500MB)
rm -rfv ~/code_aster/14.6/share/aster/tests
# Remove some documentation to save space (~100MB)
rm -rfv ~/code_aster/public/med-4.00/share/doc

# Optional: Update the tutorials exchange directory (needs to be absolute) and generate the export file.
(
    cd "${HOME}/tutorials/flow-over-heated-plate-steady-state"

    sed -i "s|exchange-directory=\"..\"|exchange-directory=\"$(pwd)\"|g" precice-config.xml

    cd ./solid-codeaster
    if [ ! -f "solid.export" ]; then
        {
            echo "P actions make_etude"
            echo "P aster_root /code_aster"
            echo "P consbtc oui"
            echo "P debug nodebug"
            echo "P display precicevm:0"
            echo "P follow_output yes"
            echo "P mclient precicevm"
            echo "P memjob 524288"
            echo "P memory_limit 512.0"
            echo "P mode interactif"
            echo "P ncpus 1"
            echo "P nomjob linear-thermic"
            echo "P origine salomemeca_asrun 1.10.0"
            echo "P protocol_copyfrom asrun.plugins.server.SCPServer"
            echo "P protocol_copyto asrun.plugins.server.SCPServer"
            echo "P protocol_exec asrun.plugins.server.SSHServer"
            echo "P rep_trav /tmp/root-23129e00f0db-interactif_4800"
            echo "P serveur localhost"
            echo "P soumbtc oui"
            echo "P time_limit 600.0"
            echo "P tpsjob 11"
            echo "P uclient precicevm"
            echo "P username precicevm"
            echo "P version stable"
            echo "A memjeveux 64.0"
            echo "A tpmax 600.0"
            echo "F comm ${HOME}/code_aster-adapter/cht/adapter.comm D 1"
            echo "F libr $(pwd)/config.comm D 90"
            echo "F libr $(pwd)/def.comm D 91"
            echo "F mmed $(pwd)/solid.mmed D 20"
            echo "R repe $(pwd)/REPE_OUT D 0"
            echo "R repe $(pwd)/REPE_OUT R 0"
            echo "F mess $(pwd)/solid.mess R 6"
            echo "F resu $(pwd)/solid.resu R 8"
        } >>solid.export
    fi
)
