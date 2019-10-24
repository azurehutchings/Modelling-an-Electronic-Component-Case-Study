import pylab as plt
import numpy as np
my_image1 = np.linspace(0, 10, 10000).reshape(100,100)
my_image2 = np.sqrt(my_image1.T) + 3
subplot(1, 2, 1)
plt.imshow(my_image1, vmin = 0, vmax = 10, cmap = 'jet', aspect = 'auto')
plt.subplot(1, 2, 2)
plt.imshow(my_image2, vmin = 0, vmax = 10, cmap = 'jet', aspect = 'auto')
plt.colorbar()