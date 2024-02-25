f = figure;
%Create a Progress bar with a range from 0 to 100  
jBarHandle = javax.swing.JProgressBar(0, 100); 
jBarHandle.setStringPainted(true);
jBarHandle.setIndeterminate(false);
%You need a pixel position for where to put the bar, I tend to do this by finding a reference object in the GUI that I'm going to replace. 
  posPanel = getpixelposition(f,true); 
    %Place the progress bar in the GUI
    javacomponent(jBarHandle,posPanel,f); 
    %Set the value of the progress bar.
    jBarHandle.setValue(fix(0));