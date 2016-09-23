import numpy as np
import urllib

# url with dataset
url = "http://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data"
# download the file
raw_data = urllib.urlopen(url)
# load the CSV file as a numpy matrix
dataset = np.loadtxt(raw_data, delimiter=",")
# separate the data from the target attributes
#print dataset
X = dataset[:,0:7]
y = dataset[:,8]
print "\n"
print "x:---",X, "\n"
print "y:---",y, "\n"


from sklearn import metrics
import sklearn
from sklearn.ensemble import ExtraTreesClassifier
import scipy
model = ExtraTreesClassifier()
model.fit(X, y)
print(model.feature_importances_)