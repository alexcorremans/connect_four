This is a Connect Four game ([Wikipedia](https://en.wikipedia.org/wiki/Connect_Four) on the command line written in Ruby. It was done TDD-style: I wrote the tests in RSpec first before writing the actual code (as much as I could).  

This project was again a huge learning experience. The planning for my first implementation was a bit lacking, meaning I ended up having to give the program an array of all possible combinations of four cells in a row in each direction. It worked perfectly but looked terribly inelegant, and I knew it was the wrong way to go about it. 

So this is my second attempt which now has a `Cell` class and some recursion. I still think it could be refactored some more but for now I'm moving on until I have a better grasp of OOP design and RSpec testing principles. 

From The Odin Project's [curriculum](https://www.theodinproject.com/courses/ruby-programming/lessons/testing-your-ruby-code)