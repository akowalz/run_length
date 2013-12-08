### Run Length

A simple run length encoder built in Ruby for encoding bit vector strings and "compressing" files via this method.  The run length encoder will reduce the length of a bit vector.  If the file is more heavily composed of one value than another (0s or 1s), the encoding will compress fairly successfully.  If not, it's a mediocre compression techique.  You can check this out using the performance_test function in run_length.rb, which lets you control "distribution" of bit values in a bit vector, and will give handy statistics for how effective the compression was.  I have yet to make an interface for this function, but generally the percent compression effectiveness was proportional to the "distribution factor" of 1s and 0s, as I called it.  Check out the code for details.


I've also included a command line interface for "compressing" text files.  "Compressing" I put in quotes because it actually converts every ASCII character in a file to binary, then converts this binary string to a run lenth encoded string, so in the end the file isn't really any shorter than the original, and in fact is almost certainly going to be longer. It will encode it though, which is cool and handy if you want to keep the contents of a file secret I guess.


A few other things are included, such as some simple tests for the decoder and encoder that I used during this project's quick development lifecycle (a Saturday afternoon).  Overall it's pretty simple and the code is pretty messy and hacked together.  This project was mostly for fun.  


#### How the encoder works

The bit vector "0001110011" will be converted to "03322"

The first bit of the encoded string is the first bit of original string, and the next numbers are the number of bits until a switch.  So "03322" says:

* Start with a 0
* The next 3 bits are 0
* The next 3 are 1
* The nex 2 are 0
* The 2 after that are 1

Pretty simple. The code for encoding and decoding is correspondingly tiny (but I bet it could be tinier).  

#### Using the command line interface

The interface for encoding text files is structured as follows:

`$ ruby file_compress.rb [compress|decompress] inpath outpath`

Example, to compress/encode the file test.txt and put the compressed copy at test_compressed.txt, run:

`$ ruby file_compress.rb compress test.txt test_compressed.txt`

To decode/decompress test_compressed.txt run:

`$ ruby file_compress.rb decompress test_compressed.txt test_decompressed.txt`

There's no real error checking on this interface, so be careful about modiying files.  The interface is still very simple and limited, but it's enough to quickly fire up and encode some files with. 

Again, I say "compressed" as the operation, but in reality the compressed file will in all likelyhood be encoded but bigger in terms of bytes than the original. Still, I thought it was a fun little tool to play around with.  I might look into *actual* compression techniques in the future.