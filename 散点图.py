# -*- coding: utf-8 -*-
"""
Created on Thu Sep 24 16:37:21 2015

@author: Eddy_zheng
"""

import scipy.io as sio  
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt

mat1 = '4a.mat' #这是存放数据点的文件，需要它才可以画出来。上面有下载地址
data = sio.loadmat(mat1)
m = data['data']

x,y,z = m[0],m[1],m[2]
ax=plt.subplot(111,projection='3d') #创建一个三维的绘图工程

#将数据点分成三部分画，在颜色上有区分度
ax.scatter(x[:1000],y[:1000],z[:1000],c='y') #绘制数据点
ax.scatter(x[1000:4000],y[1000:4000],z[1000:4000],c='r')
ax.scatter(x[4000:],y[4000:],z[4000:],c='g')

ax.set_zlabel('Z') #坐标轴
ax.set_ylabel('Y')
ax.set_xlabel('X')
plt.show()