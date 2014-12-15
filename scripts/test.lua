sys = LuaSys.Get()
gui = GUI.Get()
theos = OS.Get()
phys = Physics.Get()

gui:load_font("common/assets/mona.ttf")

sys:LoadScriptFile("common/assets/scripts/fpcamera.lua")
sys:LoadScriptFile("common/assets/scripts/interact.lua")
sys:LoadScriptFile("common/assets/scripts/menu.lua")

