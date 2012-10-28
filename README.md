# Godot

Introducing Godot, the gem what makes waiting for stuff all easy-like.


## What?

Ever need to wait for a server to come up on a given port?

    puts "My life is so much better now!" if Godot.wait("pivotallabs.com", 80)

How about that same few lines of timeout-wrapped curl matching output?

    puts "So that's doc!" if Godot.match("pivotallabs.com", 80, /doc/, "/who")


## License

See LICENSE for more information.
