import i3ipc

i3 = i3ipc.Connection()

def on_window_fullscreen(i3, e):
	if e.container.fullscreen_mode == 1:
		# Hide the bar
		i3.command('exec --no-startup-id polybar-msg cmd hide')
	else:
		# Show the bar
		i3.command('exec --no-startup-id polybar-msg cmd show')

i3.on('window::fullscreen_mode', on_window_fullscreen)
i3.main()
