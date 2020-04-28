<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13142" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12042"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
    </objects>
</document>


The pods have been deintegrated, Please initialze pods and do a pod install before running the project

I have written the network layer by the name of API. and also written methods using Google Promises for asynchronous operations. they can be tested by replacing the data fetching method in ChannelVC, but since i have not been able to test the calls and the response, so i am not sure about the stability of them. the code is working fine with the local files. 


What part of the test did i find chanllenging?

The design aspect of the test was the hardest, because i had to incorporate collection view in table view cells and to return the correct width and height, i had to do R&D in order to acheive the desired output. i tried several things like layoutDidLayoutSubviews among other methods but this helped me in learning how to dynamically update the size, and correctly configure the settings for the output. This is one of the most challenging assignments i've done so far.


what feature would i like to improve ? 

If i am guided towards what sort of animations should be there, and if the UI is provided for them it would be helpful in terms of the appeal. some sort of help or hints for the approach we should adopt for the UI would also go a long way in making things easier. 
