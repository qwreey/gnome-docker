import { Extension } from "resource:///org/gnome/shell/extensions/extension.js"
import St from "gi://St"

export default class Devtools extends Extension {
    enable() {
        global.context.unsafe_mode = true
        St.Settings.get().uninhibit_animations()
    }
    disable() { }
}
