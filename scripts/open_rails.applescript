on run argv
    set server_command to item 1 of argv & " -p " & item 2 of argv
    
    tell application "iTerm"
        activate current terminal
        tell the current terminal
            set number of columns to 150
            set number of rows to 40
            tell the current session
                write text "pwd | pbcopy"
                write text server_command
                tell i term application "System Events" to keystroke "d" using command down

                write text "cd `pbpaste`"
                write text "tail -f log/development.log"                    
            end tell
            launch session "Command Line"
            tell the current session
                write text "cd `pbpaste`"
                write text "git st"
                tell i term application "System Events" to keystroke "d" using command down

                write text "cd `pbpaste`"
                write text "rails c"
            end tell
        end tell
    end tell

end run
