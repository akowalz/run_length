require './run_length.rb'

# Returns string of binary ascii data of a file
# Gives contents of file as binary data
def file_as_binary(path)
  file = File.open(path, 'rb')
  contents = file.read
  file.close
  binary = []
  contents.split("").each do |c|
    binary.push(c.unpack("B8"))
  end
  binary.join
end

# Returns string of run length encoded ascii file
def encode_file_contents(path)
  bin = file_as_binary path
  encode(bin)
end

# Helper for convert back from binary to ascii
def bin_to_ascii(bv)
  chars = bv.scan(/.{8}/).map { |c| c.to_i(2).chr } 
  chars.join
end

# Given two paths, will compress a file in first a write encoded to second
def make_compressed_file(inpath, outpath)
  contents = encode_file_contents(inpath)
  File.open(outpath, "w") { |f| f.write(contents) } 
end

# Returns string of decoded (binary) ascii file contents
def decode_file_contents(path)
  file = File.open(path, 'rb')
  contents = file.read
  file.close
  decode(contents)
end

# Decompressed a file from runlength encoded => ascii
def make_decompressed_file(inpath,outpath)
  contents = decode_file_contents(inpath)
  File.open(outpath, "w") { |f| f.write(bin_to_ascii(contents)) }
end


# Command line interface tool for decoding and encoding files 
def interface(op, inpath, outpath)
  if op == "compress"
    make_compressed_file(inpath, outpath)
    return "File successfully compressed to #{outpath}"
  elsif op == "decompress"
    make_decompressed_file(inpath, outpath)
    return "Full successfully decompressed to #{outpath}"
  else
    "Invalid operation" 
  end
end

puts interface(ARGV[0], ARGV[1], ARGV[2])