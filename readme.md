# **Using Household Drones to Determine Agricultural Health**

## Introduction

Agriculture is incredibly important to society, but growing crops can often prove incredibly difficult, particularly for small farms that don’t have the resources to ensure they are growing their crops on well-suited land. While there are some ways to solve this problem for large farms that can afford it, there is no good universal solution to evaluating soil and ensuring your farm is land that can support crops.

## Accessibility


### How do we ensure everyone has access to our solution?

Providing mass accessibility to professional tools can be incredibly difficult because the technology involved is often very advanced and expensive. It also usually requires companies to go out to take soil samples of various locations and verify if the contents are suitable for crop growth. This often isn’t accessible for many farmers. We aim to solve this problem by using DJI Drones. By using off-the-shelf drones, we can extract this extremely important information, and allow farmers to monitor the quality of their farmland.

The DJI Mini SE is a $300 Drone that supports our software solution, and it doesn’t have to be registered with the FAA due to it being 249 grams, making it an ideal target for accessibility. These drones can be controlled by the DJI SDK, which allows the user to input coordinates that the drone can follow. We can combine this in conjunction with an easy-to-use interface to select a box around an area you want to be surveyed, and we can automatically generate an optimal path to capture the terrain.


## Data Processing


### Importing the Drone Data

After capturing data from the drone, we’ll need to have a way to parse that data and produce an actual analysis. We do this in a multi-stage process- first, we need to identify the land mass. This can be done using Gaussian Blur and OpenCV for edge detection. This allows us to extract the important parts of the terrain where farming is a consideration.


### Elevation / Runoff

Checking topography is extremely important in determining whether the land is suitable for planting crops in the first place. If there is a major concern for runoff into a particular region of land, that should be avoided to ensure crops don’t get washed away, oversaturated, covered in above sediment, or receive too much nutrients. We first take the logs from the drone, find the elevation of every chunk of data in the dataset, and parse this data to find possible runoff areas, where there are major concerns of soil oversaturated with fertilizer and nutrients from above.


### Soil Health

Before planting crops in any region, we want to ensure the soil has the appropriate contents for whatever crop you are trying to grow. Because the needs of each individual crop vary, we need to use optical recognition paired with Artificial Intelligence and Machine Learning to estimate the contents of the soil, as well as the overall health. According to ScienceDirect, “Soil color is influenced by its mineral composition as well as water and organic contents. For example, soils high in calcium tend to be white, those high in iron reddish, and those high in humus dark brown to black. Soil needs only about 5% organic material to appear black when wet.” We can use this principle to determine the contents of the soil without having to physically extract and examine samples from various parts of the region. 

![alt_text](https://cdn.discordapp.com/attachments/753331022317224058/1213592186902552646/color.png?ex=65f608cc&is=65e393cc&hm=07375cd10d29b56ab645282d3455c2bcd2c9ba20c6e2e7bec4bfb41e9405885e&"image_tooltip")


Figure 1: “Soil color and spectroradiometry”, ScienceDirect.com

According to Figure 1, we can use The Munsell System of Color Notation to quantitatively measure soil color. We can use the optical properties of soil to categorize it in such a way as to calculate its contents.

![alt_text](https://cdn.discordapp.com/attachments/753331022317224058/1213592186646564934/reflectance-wavelength.png?ex=65f608cc&is=65e393cc&hm=adcfbe32009d0cded347088694b2589a6984f47335ebcc45d813a75d961eeca9& "image_tooltip")


Figure 2. “Spectral reflectance curves for Newtonia silt loam at various moisture contents,” ScienceDirect.com

We can use the principles behind Figure 2 to determine various properties of soil, which can then be used to analyze various properties of soil.


### Crop Health

We can use a similar process to monitor the health of crops after they are grown. By using OpenCV / Machine Learning, we can keep track of the health of individual crops automatically. This can help farmers identify that there is a problem with their crops, and in some cases even identify the exact cause of it.


## Visualization


### Landscape Filtering

A major difficulty in capturing large landscapes and parsing them is filtering out unimportant edges. There are many cases where a body of water may be present on land, which is something we want to avoid parsing to avoid poisoning the actual conclusion.


![alt_text](https://cdn.discordapp.com/attachments/753331022317224058/1213590053721473044/Screenshot_from_2024-03-02_15-35-33.png?ex=65f606d0&is=65e391d0&hm=24ed499d9c1182e69995057c99676de5cd1eb65d25e59033a00c34b0159fbe36& "image_tooltip")


Figure 3. Filtering out a large body of water.

We can use a mix of numpy, OpenCV, and matplotlib to parse this data out. For this, I used “Canny”, a portion of OpenCV that allows you to take optical data as input and filters out the terrain. This is an imperfect example, but it contains enough accurate data that we can use it after minimal post-processing. This was done with a simple function in Python: 

```python
import cv2
import numpy as np
from matplotlib import pyplot as plt

image = cv2.imread('coastline.png')
edges = cv2.Canny(image,100,200)
plt.subplot(121),plt.imshow(image,cmap = 'gray')
plt.title('Original Landscape')
plt.xticks([])
plt.yticks([])

plt.subplot(122),plt.imshow(edges,cmap = 'gray')
plt.title('Filtered Landscape')
plt.xticks([])
plt.yticks([])

plt.show()
```

### Sources

[https://www.sciencedirect.com/topics/agricultural-and-biological-sciences/soil-color](https://www.sciencedirect.com/topics/agricultural-and-biological-sciences/soil-color)

[https://www.opencvhelp.org/tutorials/applications/agriculture-and-farming/](https://www.opencvhelp.org/tutorials/applications/agriculture-and-farming/)
