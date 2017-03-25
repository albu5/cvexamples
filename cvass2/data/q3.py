"""Plot depth and illustrate objects(Q3).

Usage:
  $python q3.py
Or:
  $python
  >>> execfile('q3.py')
"""

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import pylab
import scipy.io
import sys


mat_content = scipy.io.loadmat('rgbd.mat')

print 'Displaying depth. Close window to continue...'
plt.imshow(mat_content['depth'])
plt.title('Depth, red pixels are far away while blue ones are close.')
pylab.show()

print 'Displaying the objects of interest. Close window to continue...'
for obj_id in xrange(1, 5):
  plt.imshow(mat_content['labels'] == obj_id)
  plt.title('Object {}'.format(obj_id))
  pylab.show()

# Find all pixels that belong to the first object.
x, y = np.where(mat_content['labels'] == 1)
print 'pixel coordinate that belongs to first object(only print first 3):'
for p in range(3):
  print '({}, {})'.format(x[p], y[p]),
sys.stdout.flush()

# Plot 3D data
print 'plot3() equivalent in python'
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
t = np.linspace(0, 10 * np.pi, num=500)
ax.plot(xs=np.sin(t), ys=np.cos(t), zs=t)
pylab.show()
