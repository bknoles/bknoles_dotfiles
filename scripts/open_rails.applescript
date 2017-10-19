on run argv
    set server_command to item 1 of argv & " -p " & item 2 of argv
    
    tell application "iTerm2"
        tell current window
            set tab1 to current tab
            set tab1_session1 to current session
            tell tab1_session1
                set columns to 150
                set rows to 40
                do shell script "pwd | pbcopy"
            end tell

            set tab2 to (create tab with default profile)
            set tab2_session1 to current session

            tell tab2_session1
                write text "cd `pbpaste`"
                write text "rails c"
                set tab2_session2 to (split vertically with default profile)
            end tell

            tell tab2_session2
                write text "cd `pbpaste`"
                write text "tail -f log/development.log"                    
            end tell

            set tab3 to (create tab with default profile)
            set tab3_session1 to current session
            
            tell tab3_session1
                write text "cd `pbpaste`"
            end tell
            
            select tab1

            tell application "System Events" to keystroke "r" using command down
            tell tab1_session1
                write text "git status"
            end tell
        end tell
    end tell
end run
