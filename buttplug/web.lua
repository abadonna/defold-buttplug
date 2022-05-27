local M = {}

M.init = function()
	if not html5 then
		return
	end

	--006fff
	
	html5.run([[
		DEVICE = null;
		var s = document.createElement('script');
		s.setAttribute('src','https://cdn.jsdelivr.net/npm/buttplug/dist/web/buttplug.min.js');
		s.onload = () => {
			var sample = document.getElementsByClassName('button')[0];
			var color = window.getComputedStyle(sample, null).color;

			var btn = document.createElement('div');
			btn.innerHTML = 'Connect';
			btn.setAttribute('class', 'button');
			btn.style.marginLeft = '10px';
			btn.style.backgroundImage = "url(\"data:image/svg+xml,%3Csvg version='1.1' id='Capa_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px' width='16px' height='16px' viewBox='0 0 45.743 45.743' style='enable-background:new 0 0 45.743 45.743;' xml:space='preserve'%3E%3Cg fill='" + color  + "'%3E%3Cpath d='M34.199,3.83c-3.944,0-7.428,1.98-9.51,4.997c0,0-0.703,1.052-1.818,1.052c-1.114,0-1.817-1.052-1.817-1.052 c-2.083-3.017-5.565-4.997-9.51-4.997C5.168,3.83,0,8.998,0,15.376c0,1.506,0.296,2.939,0.82,4.258 c3.234,10.042,17.698,21.848,22.051,22.279c4.354-0.431,18.816-12.237,22.052-22.279c0.524-1.318,0.82-2.752,0.82-4.258 C45.743,8.998,40.575,3.83,34.199,3.83z'/%3E%3C/g%3E%3C/svg%3E\")";
			sample.insertAdjacentElement('afterend', btn);
			btn.addEventListener("click", async () => {
				await Buttplug.buttplugInit();
				let client = new Buttplug.ButtplugClient("sexandglory.com");
				client.addListener('deviceadded', async (device) => {
					if (device.messageAttributes(Buttplug.ButtplugDeviceMessageType.VibrateCmd) !== undefined) {
						DEVICE = device;
						await client.stopScanning();
					}
				})

				client.addListener("deviceremoved", async (device) => {DEVICE = null;});
				
				await client.connect(new Buttplug.ButtplugEmbeddedConnectorOptions());
				await client.startScanning();
			});
		};
		document.body.appendChild(s);
	]])

	html5.run("console.log(window.DEVICE)")
end

M.is_ready = function()
	if not html5 then
		return false
	end

	return html5.run("typeof Buttplug !== 'undefined'") ~= 'false'
end

M.has_device = function()
	if not html5 then
		return false
	end
	return html5.run("(typeof DEVICE !== 'undefined') && (DEVICE != null)") ~= 'false'
end

M.vibrate = function(speed, duration)
	if not M.has_device() then
		return
	end

	html5.run("await DEVICE.vibrate(" ..  speed .. ");")
	if duration then
		timer.delay(duration, false, M.stop)
	end
end

M.stop = function()
	if not M.has_device() then
		return
	end

	html5.run("await DEVICE.stop();")
end

return M