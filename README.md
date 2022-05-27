# defold-buttplug
Module to work with Buttplug.io in Defold. WIP, so far only HTML5 target.

## how to use
This module works with standart Defold html templates.

1. Add dependency, learn more in [official manual](https://defold.com/manuals/libraries/).
2. Add require, e.g.
```
    local buttplug = require "buttplug.web"
```
3. Init buttplug
```
buttplug.init()
```
You should see "connect" button on your web page after this:

![buttons](https://github.com/abadonna/defold-buttplug/blob/main/screen.jpg)

4. Click on this button and connect your device, [list of devices](https://iostindex.com/?filter0ButtplugSupport=7).
5. Vibrate!
```
buttplug.vibrate(speed, duration)
```

