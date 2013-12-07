### Run Length

A simple run length encoder for bit vector strings.  Just threw it together one afternoon for fun.  The code isn't particuarly clean and it doesn't yet have any interfaces, but I'm interested in expanding this to "compress" files.  It doesn't really do a ton of compression, but it will reduce a file size a bit, depending on the distribution of 1s and 0s, curious how this would work on ASCII files converted to binary?  Would probably do little because the probability of a 0 and 1 is close to 50%.  I'll check it out anyway. 

A few simple unit tests and a performance test for different distribution probabilities and are included all in the same file.  I might split it up and make it cleaner in the future, this is just what I used while I was working on it.  Compression is cool!  


#### How it works

The bit vector "0001110011" will be converted to "03322"

The first bit of the encoded string is the first bit of original string, and the next numbers are the number of bits until a switch.  So "03322" says:

* Start with a 0
* The next 3 bits are 0
* The next 3 are 1
* The nex 2 are 0
* The 2 after that are 1

Pretty simple. The code for encoding and decoding is correspondingly tiny (but I bet it could be tinier).  