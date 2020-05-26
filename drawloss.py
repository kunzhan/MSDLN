import caffe   
caffe.set_device(0)  
caffe.set_mode_gpu()   
import numpy as np
from numpy import zeros,arange
import matplotlib.pyplot as plt
import sys
import os
from matplotlib.pyplot import twinx
from math import ceil
# using SGDSolver
solver = caffe.SGDSolver('./draw/solver_indiap.prototxt')  
  
# equals to solver max_iter
niter = 18000
# display interval
display= 100  
  
# 
test_iter = 49
# 
test_interval =100  
  
# initializtion
train_loss = zeros(int(ceil(niter * 1.0 / display)))   
test_loss = zeros(int(ceil(niter * 1.0 / test_interval)))  
test_acc = zeros(int(ceil(niter * 1.0 / test_interval)))  
  
# iteration 0 ignore
solver.step(1)  
  
# axiluary variable
_train_loss = 0; _test_loss = 0; _accuracy = 0  
# calcu
for it in range(niter):  
    # calcu
    solver.step(1)  
    # one iteration to train batch_size images 
    _train_loss += solver.net.blobs['SoftmaxWithLoss1s'].data  
    if it % display == 0:  
        # average train loss  
        train_loss[it // display] = _train_loss / display  
        _train_loss = 0  
  
    if it % test_interval == 0:  
        for test_it in range(test_iter):  
            # one test 
            solver.test_nets[0].forward()  
            # test loss  
            _test_loss += solver.test_nets[0].blobs['SoftmaxWithLoss1s'].data  
            # test accuracy  
            _accuracy += solver.test_nets[0].blobs['Accuracy1s'].data  
        # average test loss  
        test_loss[it / test_interval] = _test_loss / test_iter  
        # average test accuracy  
        test_acc[it / test_interval] = _accuracy / test_iter  
        _test_loss = 0  
        _accuracy = 0  
  
# plot train loss test loss and accuracy curves
print '\nplot the train loss and test accuracy\n'  
_, ax1 = plt.subplots()  
ax2 = ax1.twinx()  
  
# train loss -> gree 
ax1.plot(display * arange(len(train_loss)), train_loss, 'g')  
# test loss -> yellow  
ax1.plot(test_interval * arange(len(test_loss)), test_loss, 'y')  
# test accuracy -> red
ax2.plot(test_interval * arange(len(test_acc)), test_acc, 'r')  
  
ax1.set_xlabel('iteration')  
ax1.set_ylabel('loss')  
ax2.set_ylabel('accuracy')  
plt.show()