property countdown : 2 -- Set the timer in seconds
property lastKeyTime : current date -- Track the time of the last key input

on idle
    set currentTime to current date
    if (currentTime - lastKeyTime) > countdown then
        -- Simulate F19 key press
        do shell script "osascript -e 'tell application \"System Events\" to key code 127'"
        -- Reset the timer
        set lastKeyTime to currentTime
    end if
    return 0.1 -- Set the idle interval (in seconds)
end idle

on run
    -- Initialize the timer
    set lastKeyTime to current date
end run


