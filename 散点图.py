# -*- coding: utf-8 -*-
"""
Created on Thu Sep 24 16:37:21 2015

@author: Eddy_zheng
"""

#import scipy.io as sio  
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from sys import argv
import re

projectname , fileName = argv
file_read = open(fileName, "r")
x,y,z = [], [], []
for line in file_read:
	textArray = re.split(r'[\s]+', line);
	#print textArray
	x.append(float(textArray[1]))
	y.append(float(textArray[8]))
	z.append(float(textArray[9]))

ax=plt.subplot(111,projection='3d') #创建一个三维的绘图工程

#将数据点分成三部分画，在颜色上有区分度
ax.scatter(x[:1000],y[:1000],z[:1000],c='y') #绘制数据点
ax.scatter(x[1000:4000],y[1000:4000],z[1000:4000],c='r')
ax.scatter(x[4000:],y[4000:],z[4000:],c='g')

ax.set_zlabel('Z') #坐标轴
ax.set_ylabel('Y')
ax.set_xlabel('X')
plt.show()