import numpy
import os

import numpy
import os

from nmt import train

def main(job_id, params):
    print params
    validerr = train(saveto=params['model'][0],
                     reload_=params['reload'][0],
                     dim_word=params['dim_word'][0],
                     dim=params['dim'][0],
                     n_words=params['n-words'][0],
                     n_words_src=params['n-words-src'][0],
                     decay_c=params['decay-c'][0],
                     clip_c=params['clip-c'][0],
                     lrate=params['learning-rate'][0],
                     optimizer=params['optimizer'][0],
                     patience=1000,
                     maxlen=50,
                     batch_size=32,
                     valid_batch_size=32,
                     validFreq=100,
                     dispFreq=10,
                     saveFreq=100,
                     sampleFreq=100,
                     datasets=['../../data/train.en.tok',
                               '../../data/train.de.tok'],
                     valid_datasets=['../../data/val.en.tok',
                                     '../../data/val.de.tok'],
                     dictionaries=['../../data/train.en.tok.pkl',
                                   '../../data/train.de.tok.pkl'],
                     use_dropout=params['use-dropout'][0],
                     overwrite=False)
    return validerr

if __name__ == '__main__':
    main(0, {
        'model': ['model_hal.npz'],
        'dim_word': [512],
        'dim': [1024],
        'n-words': [15000],
        'n-words-src':[9000],
        'optimizer': ['adadelta'],
        'decay-c': [0.],
        'clip-c': [1.],
        'use-dropout': [False],
        'learning-rate': [0.0001],#changed from 0.0001
        'reload': [True]})
