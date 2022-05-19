# Generation of Synthetic Images for Composite Prepreg Sheets

## How to Create an HDRI (High Dynamic Range Imaging)
1. First you will need to purchase a shiny metal sphere at least 2 inches in diameter [link](https://www.amazon.com/dp/B01KCB5UWO?ref_=cm_sw_r_cp_ud_dp_04AWNNNZG4YY9894WPQ2). Place this chrome sphere within the cell where the composite layup task will be performed
2. Set up a camera on a tripod approximately 20 feet away from the sphere
3. From this spot, take photographs of the sphere on every exposure setting that the camera allows
4. Repeat the same process, this time taking photos from a different angle, about 90˚ away from the initial position. Make sure to take all these photos at the same time of day that you plan to be doing carbon fiber layups; changes in ambient light will affect the accuracy of the HDRI
5. Use an imaging software like Photoshop software to combine all images into an HDRI

## How to use the blend File to generate PhotoRealistic CGI Images of the Carbon Fiber
1. Open the blend file in blender software [link](https://www.blender.org/)
2. On line 5, replace the “2” in the parentheses with the number of meshes you want to render
3. On line 8, replace the text inside the quotes with the pathname of the .stl’s in your folder of .stl files. The files should be named serially, such as: mesh1.stl, mesh2.stl, etc
4. When you press the “▶” button at the top of the scripting panel, the program will render and export the files.