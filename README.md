#  AppIconMaker

AppIconMaker is a simple command line utility for creating iOS app icon sets.

## The old way

Typically adding an icon set to an iOS application involves four steps.

1.  Create a large (1024x1024) PNG image of your icon using the graphics software of your choice.
2.  Duplicate, rename, and resize the image 13 times to create a full set of icons of various point sizes and scale factors consistent with Apple's [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/).
3.  In xCode add a new app icon set to your app's asset catalogue.
4. Drag each of the 13 images generated in step 2 into an appropriate slot in the app icon set.

Step 1 can be creative and fun, but steps 2 through 4 are tedious and boring!

## The new way

AppIconMaker was designed to take the drudgery out of app icon creation by generating a complete app icon set from a single PNG image. Let's assume you've installed AppIconMaker in a directory included in your shell's `$PATH` and have created a PNG file called `MyIcon.png`. 
Launch a Terminal, navigate to the directory you'd like to work in, and type the command:

    AppIconMaker MyIcon.png

AppIconMaker will then create an app icon set called `AppIcon.appiconset` (it's actually a subdirectory containing the needed icon images and some JSON metadata).  Simply drag this icon set into your asset catalogue and you're good to go!

There really isn't any more to it than that, but if you need help or would like to see what options are available, type

    AppIconMaker -h

## Installing AppIconMaker

To install AppIonMaker you'll need to clone this project and build it.  Assuming you're using xCode, you can find the resulting executable file by right clicking on the file `AppIconMaker` under the `Products` group in the project navigator and selecting "Show in Finder".  You can then move the executable file to the location of your choosing.  I recommend putting it in a directory included in your shell's `$PATH` so you don't have to type a full path every time you use it.
