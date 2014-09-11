sys = LuaSys.Get()

sys:LoadScriptFile("assets/scripts/fpcamera.lua")

gui = GUI.Get()
gui:LoadFont("assets/mona.ttf")
GUI.cdoc = gui:LoadDoc("test.rml")
gui:ShowDoc(GUI.cdoc)
