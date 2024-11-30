#! /bin/bash
# Silly script that sets webcam configurations correctly so I don't have to do that manually every time

# Change base settings
v4l2-ctl --set-ctrl brightness=52
v4l2-ctl --set-ctrl contrast=58
v4l2-ctl --set-ctrl saturation=55

# Deactivate auto exposure and adjust manually
v4l2-ctl --set-ctrl auto_exposure=1
v4l2-ctl --set-ctrl exposure_time_absolute=30

# Deactivate auto focus and adjust manually
v4l2-ctl --set-ctrl focus_automatic_continuous=30
v4l2-ctl --set-ctrl focus_absolute=450

# Deactivate auto white balance and adjust manually
v4l2-ctl --set-ctrl white_balance_automatic=1
v4l2-ctl --set-ctrl white_balance_temperature=4750
