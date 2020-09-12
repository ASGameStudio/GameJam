extends Node

#This script holds global signals which can be accessed
#via Event.emit_signal() or Event.connect() functions.
signal update_time()
signal player_energy(value)
