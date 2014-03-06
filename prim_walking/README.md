Implementation of [Prim's Algorithm](WIKIPEDIA ABOUT PRIMS)

A bunch of random walkers are generated and walk around.
A bunch of "edge" objects are created which connects one "vertex"(walker) to another.
Each edge object has a "cost" which is calculated based on distance between the 2 walker/vertices and some other stuff sometimes. The algorithm finds the cheapest path to connect allll the vertices. 
Each walker has a randomly set color, and each frame the paths between vertexes are drawn.

Sometimes this sketch gets a "null pointer exception" or something on startup, just keep hitting play till it kicks off.

TODO: write some code that ensures that every generated point ends up as a vertex so the exception stops happening because I think that's the issue. 
