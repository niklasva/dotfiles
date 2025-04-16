from mido import MidiFile

file = MidiFile("doom.mid")
for msg in file:
   if msg.is_meta: continue
   print(msg)
