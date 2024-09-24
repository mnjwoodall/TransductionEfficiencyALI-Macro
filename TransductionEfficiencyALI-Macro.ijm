/*  
 * TRANSFECTION RATIO in ALI cultures  
 * 
 * Copyright (c) 2019 Max Woodall 
 * 
 * Assumes fluorescence in green/red channels 
 * with background correction and contrast enhancement  
 */  

// Last updated 2019-08-15 // 12:20 PM 

/*  
 * NOTE: Hardcoded minimum size cutoff is 15 pixels  
 * NOTE: Assumes the chosen directory only has .tif files to be processed (no uppercase for .tif)   
 */  

// Uncomment for debugging pause 
// waitForUser("Debug point 1", "Press anything to continue");

var myDir = "";  

macro "mw2-runner [1]" {  
    myDir = getDirectory("Choose a Directory (all .TIF files will be processed)");  
    list = getFileList(myDir);  

    print("\\Clear"); // Clear the log window 

    // Clear Summary window if it exists  
    if (isOpen("Summary"))   
        selectWindow("Summary");  
    // run("Close");

    Table.create("Summary"); // Creates a new Summary table without clearing existing data

    // setBatchMode(true); // Uncomment if batch processing is needed 

    for (i = 0; i < list.length; i++) {  
        listelement = toLowerCase(list[i]);  
        if (endsWith(listelement, ".tif")) // Process only .tif files 
            overlay1(list[i], myDir, i);  
        // print(list[i]);  
    }  
    // setBatchMode(false);  

    // Write out "Summary" with count info  
    selectWindow("Summary");  
    saveAs("TXT", myDir + '\\' + "results" + "\\" + "summary");  
    Table.rename("summary.txt", "Summary");  
    // close("Summary");

    // close("*"); // Uncomment if you wish to close all windows at the end

    print("myDir=", myDir);  
    print("Done!");  
}  

/*************** Unused functions ***************/ 

function overlay0(Imagename, n)  {  
    name1 = File.getName(Imagename); // Get name without path  
    name1stem = substring(name1, 0, lengthOf(name1) - 4);  
    name1path = File.directory;  

    print("n=", n);  
    print("name1=", name1);  
    print("name1stem=", name1stem);  
    print("name1path=", name1path);  
}  

/*************** Functions in use ***************/  

function overlay1(Imagename, path, n)  {  
    open(Imagename);  

    name1 = File.getName(Imagename); // Get name without path  
    name1stem = substring(name1, 0, lengthOf(name1) - 4);  
    name1path = File.directory;  

    dest_dir1 = myDir + "results"; // Create results directory  
    File.makeDirectory(dest_dir1);  

    if (!File.exists(dest_dir1)) 
        exit("Unable to create directory");  

    print("name1=", name1);  
    print("name1stem=", name1stem);  
    print("name1path=", name1path);  

    run("Subtract Background...", "rolling=5 sliding"); 
    run("Median...", "radius=2"); 
    setAutoThreshold("RenyiEntropy dark"); 
    run("Convert to Mask"); 
    run("Erode"); 
    run("Analyze Particles...", "size=15-Infinity show=Masks display summarize");  

    // Write out result image 
    selectWindow("Mask of " + name1);  
    saveAs("TIF", dest_dir1 + '\\' + name1stem + "-RESULT");  

    // Uncomment for debugging pauses
    // waitForUser("Debug point 1", "Press anything to continue");

    wait(1000);  

    close("*");  
}
