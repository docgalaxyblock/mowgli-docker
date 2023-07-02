################################
##     Important Settings     ##
################################

# Uncomment and set to coordinates near your future docking station, this will be your map origin.
# There might be a case that you don't need those if you using OM_USE_RELATIVE_POSITION=True
export OM_DATUM_LAT=48.CHANGEME
export OM_DATUM_LONG=11.CHANGEME

# NTRIP Settings
# Set to False if using external radio plugged into the Ardusimple board.
export OM_USE_NTRIP=True
export OM_NTRIP_HOSTNAME=caster.centipede.fr
export OM_NTRIP_PORT=2101
export OM_NTRIP_USER=centipede
export OM_NTRIP_PASSWORD=centipede
export OM_NTRIP_ENDPOINT=OUIL

################################
## Hardware Specific Settings ##
################################

# The type of mower you're using, used to get some hardware parameters automatically
# CUSTOM (put your configs in ~/mower_params/)
export OM_MOWER="CUSTOM"

# Your Hardware Version (more a firmware version, really). Check the OpenMower docs (https://www.openmower.de/docs) for the firmware versions.
# Empty ("") on a mowgli build
export OM_HARDWARE_VERSION=""

# Select your ESC type
# Supported values as of today:
# xesc_mini: for the STM32 version (VESC)
# xesc_2040: for the RP2040 version (very experimental!)
export OM_MOWER_ESC_TYPE="xesc_mini"

# Select your gamepad
# Currently supported: ps3, steam_stick, steam_touch, xbox360
export OM_MOWER_GAMEPAD="xbox360"

# Set to true to record your session.
# Output will be stored in your $HOME
# export OM_ENABLE_RECORDING_ALL=False

################################
##        GPS Settings        ##
################################
# Relative Positioning vs LatLng coordinates
# If OM_USE_RELATIVE_POSITION=False, we're using an arbitrary point as map origin. This point is called the DATUM point and
# needs to be set using OM_DATUM_LAT and OM_DATUM_LONG below.
# If OM_USE_RELATIVE_POSITION=True, we're using the ublox NAVRELPOSNED messages as position.
# This makes your base station the map origin
# For it recommended to set OM_USE_RELATIVE_POSITION to False. This way you can move your base station without re-recording your maps and it's also more compatible overall.
export OM_USE_RELATIVE_POSITION=False

# GPS protocol. Use UBX for u-blox chipsets and NMEA for everything else
export OM_GPS_PROTOCOL=UBX

# If you want to use F9R's sensor fusion, set this to true (you will also need to set DATUM_LAT and DATUM_LONG.
# Consider this option unstable, since I don't have the F9R anymore, so I'm not able to test this.
# IF YOU DONT KNOW WHAT THIS IS, SET IT TO FALSE
export OM_USE_F9R_SENSOR_FUSION=False


################################
##    Mower Logic Settings    ##
################################
# The distance to drive forward AFTER reaching the second docking point
export OM_DOCKING_DISTANCE=1.0

# The distance to drive for undocking. This needs to be large enough for the robot to have GPS reception
export OM_UNDOCK_DISTANCE=1.0

# How many outlines should the mover drive. It's not recommended to set this below 4.
export OM_OUTLINE_COUNT=4

# Mowing angle offset -180 deg - +180 deg, 0 = east, -90 = north. If mowing angle offset is not absolute it gets added to the auto detected angle which is set by the first 2 m of recorded outline.
export OM_MOWING_ANGLE_OFFSET=0
export OM_MOWING_ANGLE_OFFSET_IS_ABSOLUTE=False

# The width of mowing paths.
# Choose it smaller than your actual mowing tool in order to have some overlap.
# 0.13 works well for the Classic 500.
export OM_TOOL_WIDTH=0.13

# Voltages for battery to be considered full or empty
export OM_BATTERY_EMPTY_VOLTAGE=25.0
export OM_BATTERY_FULL_VOLTAGE=28.5

# Mower motor temperatures to stop and start mowing
export OM_MOWING_MOTOR_TEMP_HIGH=80.0
export OM_MOWING_MOTOR_TEMP_LOW=40.0

export OM_GPS_WAIT_TIME_SEC=10.0
export OM_GPS_TIMEOUT_SEC=5.0

# Mowing Behavior Settings
# True to enable mowing motor
export OM_ENABLE_MOWER=True

# Set the automatic start value based on required behaviour
#  2 - AUTO - mow whenever possible
#  1 - SEMIAUTO - mow the entire map once then wait for manual start atgain
#  0 - MANUAL - mowing requires manual start (default if unset)
export OM_AUTOMATIC_MODE=0

export OM_OUTLINE_OFFSET=0.05

export OM_NO_COMMS=true

# Set default GPS antenna offset
export OM_ANTENNA_OFFSET_X=0.3
export OM_ANTENNA_OFFSET_Y=0.0

# Set distance between wheels in m
export OM_WHEEL_DISTANCE_M=0.325

# Set default ticks/m
export OM_WHEEL_TICKS_PER_M=300.0

# Heatmap UNSET or om_gps_accuracy
export OM_HEATMAP_SENSOR_IDS=om_gps_accuracy

# source the default values for the hardware platform.
# you only need this line on non-docker installs. in the docker, it will be done automatically.
# source $(rospack find open_mower)/params/hardware_specific/$OM_MOWER/default_environment.sh
