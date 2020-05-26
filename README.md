## MSDLN
- Prerequisites
  - Python 2.7
  - [CAFFE](https://github.com/BVLC/caffe)
- Step 1
```m
gene_index.m
```
- Step 2
```sh
bash train.sh
```
- Step 3
```sh
bash test.sh
```
- Step 4
```sh
bash extract_prob.sh
```
- Step 5
```m
calculating_result.m
```
## Citation
We appreciate it if you cite the following paper:
```
@Article{HE2020MSDLN,
  author =  {He, Ying and Su, Wei and Li, Xiun and Zhan, Kun},
  title =   {Multi-scale dual-Level network for hyperspectral image classification},
  journal = {Journal of Electronic Imaging},
  year =    {2020},
  volume =  {28},
  number =  {3},
  pages =   {00}
}
```

## Contact
https://kunzhan.github.io/

If you have any questions, feel free to contact me. (Email: `ice.echo#gmail.com`)

## Reference
- This code is heavily borrowed from the baseline [DFFN](https://github.com/weiweisong415/Demo_DFFN)