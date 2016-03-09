#!/bin/bash -x
# This script sets up development and data environments for 
# a local machine, copy under your home directory and run.
# Note that, Theano is NOT installed by this script.

#Modified for wmt16

# code directory for cloned repositories
CODE_DIR=/veu4/usuaris29/ztang/dl4mt/codes

# code repository 
CODE_CENTRAL=https://github.com/Z-TANG/dl4mt-material

# our input files will reside here
DATA_DIR=/veu4/usuaris29/ztang/dl4mt/data

# our trained models will be saved here
MODELS_DIR=/veu4/usuaris29/ztang/dl4mt/models


# clone the repository from github into code directory
if [ ! -d "${CODE_DIR}" ]; then
    mkdir -p ${CODE_DIR}
    git clone ${CODE_CENTRAL} ${CODE_DIR}
fi

# download the training and validation sets and extract
python ${CODE_DIR}/data/download_files.py \
    -s='en' -t='de' \
    --source-dev=val.en \
    --target-dev=val.de \
    --outdir=${DATA_DIR}

# tokenize corresponding files
perl ${CODE_DIR}/data/tokenizer.perl -l 'en' < ${DATA_DIR}/val.en > ${DATA_DIR}/val.en.tok
perl ${CODE_DIR}/data/tokenizer.perl -l 'de' < ${DATA_DIR}/val.de > ${DATA_DIR}/val.de.tok
perl ${CODE_DIR}/data/tokenizer.perl -l 'en' < ${DATA_DIR}/train.en > ${DATA_DIR}/train.en.tok
perl ${CODE_DIR}/data/tokenizer.perl -l 'de' < ${DATA_DIR}/train.de > ${DATA_DIR}/train.de.tok

# extract dictionaries
python ${CODE_DIR}/data/build_dictionary.py ${DATA_DIR}/train.en.tok
python ${CODE_DIR}/data/build_dictionary.py ${DATA_DIR}/train.de.tok

# create model output directory if it does not exist 
if [ ! -d "${MODELS_DIR}" ]; then
    mkdir -p ${MODELS_DIR}
fi

# check if theano is working
python -c "import theano;print 'theano available!'"
