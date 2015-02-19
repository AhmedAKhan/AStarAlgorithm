This is the A* algorithm implemented in different languages.

IOS
In the IOS folder there is a working prototype of the player (red circle) is travelling to its destination (blue circle) using the A* aglorithm. 

The only classes that are responsible for finding the path is AStarAlgorithm and AStarNode. 

If you want to add this into your code just copy those two files into your code.
The AStarAlgorithm class needs to be given a starting position and a destination for its constructor 
for example: [[AStarAlgorithm alloc] initWithPlayer:playerPosition andDestination:destinationPosition andBoard:positions];


This will create the path and to access it you can use the function getNextPositionForPlayer which will return the next point that object should go to to get to its destination