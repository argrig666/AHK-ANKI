SetTitleMatchMode 2
f1::InputLookUp()
f2::ActivateAnkiBrowse()
f3::activateankiadd()
f4::SnippingTool() ;ClipboardURLtoImage()
f8::BoldLine()
Numpad7::SnippingTool()
^x::URLtoFile()


BoldLine()
{
	send +{home}
	clipboard:=
	sleep 50
	send ^c
	sleep 50
	if clipboard is not Space
		{
		FileAppend %Clipboard% is NOT empty `r`n, *
		send {del}
		}
		else
		FileAppend %Clipboard% `r`n, *	
	Send +{end}
	send ^b
	send {home}
}

^w::GoogleOpenURL()
^Backspace::ExitApp
^e::SearchRadiopaedia()
:*:qq::Findings?`nDiagnosis?{tab}
:*:ww::`nFindings?`nTop 3 differentials?{tab}
:*:/b::
RandomBeta()
return


^Numpad8:: Send {U+21e7}

^Numpad2:: send {U+21e9}
#if WinActive("Edit Current") or winactive("Add") or WinActive("Browse (")
CapsLock::Parenthesize()
^Capslock::ParenthesizeWord()

Numpad8:: Send {U+2191}
Numpad2:: send {U+2193}

;;;;;;;;;;;;;;;;;;;;;;;;;;
global Active_Window_Title


#Include Gdip_All.ahk

#If WinActive("Browse (")
MButton::ChangeColor()
`::esc
+`::~
#If

#If winactive("User 1")
`::Esc
#if

#If WinActive("Add")
`::AddAndSwitch()
+`::~
#If

#If WinActive("Edit Current") or (winactive("Add")&& (WindowClassUnderMouse()="Qt5QWindowIcon"))
MButton::ChangeColor()
`::esc
+`::~
#If

RandomBeta()
{
random, RND, 1, 4

if RND=1
	SendInput Betas are known to internalize defeat. Losing is their identity.
else if RND=2
	SendInput I like owning betas, it prepares them for the upcoming failures.
else if RND=3
	SendInput Not a fan of playing with betas, but somebody needs to own them too.
else if RND=4
	SendInput My old man told me once: "Suckers need to be owned like suckers."
}

WindowClassUnderMouse()
{
	MouseGetPos,,, hwnd
	;Print(hwnd)
	WinGetClass, strWinClass, ahk_id %hwnd%
	;print(strWinClass)
	return strWinClass
}


Print(strArg)
{
	FileAppend %strArg% `r`n, *
}

WindowUnderMouseActive(strWindowTitle)
{
	SetTitleMatchMode, 2
	IfWinNotActive, %strwindowtitle%
	{
		;FileAppend %strwindowtitle% `r`n Quadramed is not active `r`n, *
		return false
	}
	MouseGetPos,,, hwnd
	winget strActiveWindow, , A 
	;FileAppend %HWND%  %stractivewindow% `r`n, *
	
	if HWND = %strActiveWindow%
	{
		;FileAppend Active `r`n, *
		return true
	}
	else
	{
		;FileAppend NOT Active `r`n, *
		return false
	}
	
}


SnippingTool()
{
	IfWinExist Snipping Tool
	{
		winactivate Snipping Tool
		sleep 20
		send !N
	
	}



}

InputLookUp()
{
	InputBox strInput
	if (strInput="")
		return
	
	URL:="https://www.google.com/search?tbm=isch&q=" . strInput . " radiology"	
	run %URL%
}

ActivateAnkiBrowse()
{
	IfWinExist Browse
	{
		winactivate Browse
		;sleep 200
		;FileAppend Browse worked `r`n, *
		;send +{tab}
	}
	else
	{
		winactivate - Anki
		sleep 100
		send b
		sleep 50
		;send {tab}
	}
}

ActivateAnkiAdd()
{
	SetTitleMatchMode 1
	IfWinExist Add
		winactivate Add
	else
	{
		winactivate User 1 - Anki
		sleep 100
		send a
	}
}

AddAndSwitch()
{
	send ^{enter}
	sleep 200
	;WinActivate %Active_Window_Title%
	
	;If WinActive("Add") or WinActive("Browse (")
	;	WinActivate Chrome
	
	;FileAppend  %Active_Window_Title% `r`n, *
}

ChangeColor()
{
	clipboard:=""	;this is to check if anything is highlighted
	send ^c
	
	
	;FileAppend %clipboard%, *
	sleep 50
	if (clipboard="")	;if highlighted - no need to doubleclick and highlight
		mouseclick left, , ,2
	
	
	send {F7}
	sleep 20
	;send {F8}			;opens select font color
	;WinWaitActive Select Color
	;send {enter}
	send {right}

}


GoogleOpenURL()
{
	clipboard:=""
		
	send ^{insert}
	sleep 100
	
	
	
	if (clipboard!="") 
	{
		;if no text is currently highlighted we're in a browser ready to copy an image into an anki card
		FileAppend %clipboard% %A_hour%:%A_min% `r`n, *
		URL:="https://www.google.com/search?tbm=isch&q=" . clipboard . " radiology"	
		;URL:="https://duckduckgo.com/?q=" clipboard " radiology" "&t=h_&iax=images&ia=images"
		;FileAppend %URL% `r`n, *
		run %URL%
	}	
	else
	{
		
		
		; if mouse is above a PDF open in adobe reader
		If (WindowClassUnderMouse()="AcrobatSDIWindow")	; for acrobad DC
		{	
			
			; if acrobat is above the mouse cursor but not active
			If not WinActive("ahk_class AcrobatSDIWindow")
			{
				;mouseclick left
				;sleep 50
				;print("Acrobat under mouse but not active")	
			}
			mouseclick left
			sleep 50
			
		}
		
		;FileAppend Clipboard is Empty  `r`n, *
		mouseclick right
		sleep 150
		send y
		sleep 50
		
		If WinExist("Edit Current")
		{
			winactivate Edit Current
			WinWaitActive Edit Current
			sleep 50	
			send ^2
			sleep 50
			send ^v
		}
		else If (WinExist("Add"))
		{
			WinActivate Add
			sleep 50
			
			send ^v
			return
		}
		else if (winexist("Browse ("))
		{
		WinActivate Browse (
			sleep 50
			send ^v
			return
		
		}
		
		else
		{
			
			;FileAppend USER 1 has to be activated
			WinActivate User 1
			WinWaitActive User 1
			
			sleep 50
			send {esc}
			sleep 10
			send e
			
			WinWaitActive Edit Current, ,0.5
			if (ErrorLevel!=0) 
			{
								
				send a
				sleep 800
				send ^v
				send {enter}
				return				
			}
			sleep 1000
			send {tab 2}
			sleep 10
			send {enter}
			send ^v
		}
		
		
	}	
	
}

ParenthesizeWord()
{
	send ^{left}(^{right}{left})
}

Parenthesize()
{
	send {home}({end})
}


SearchRadiopaedia()
{
clipboard:=""
send ^c
sleep 100
if (clipboard="")
	return

URL:="https://radiopaedia.org/search?utf8=?&q=" . Clipboard
;URL:="chrome.exe google.com -incognito"

run %URL%
}

ClipboardURLtoImage()
{
	URL:=clipboard
	
	UrlDownloadToFile %url%, last1.jpg 
	sleep 100

	
	pToken := Gdip_Startup()
	Gdip_SetBitmapToClipboard(pBitmap := Gdip_CreateBitmapFromFile("last1.jpg"))
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
	

	sleep 20
	send ^v
	FileDelete last1.jpg

}

URLtoFile() ;transforms a highlighted URL into an image
{
	;Clipboard:=""
	;send ^c
	if clipboard=""
		return
	sleep 100
	
	FilePath := A_WorkingDir "\last.jpg"
	URL:=clipboard
	
	UrlDownloadToFile %url%, last1.jpg ;%filepath%
	sleep 100
	;fileread clipboard, "last.jpg"
	
	;FileAppend %errorlevel% `r`n, *
	;FileAppend %filepath% `r`n, *
	
	pToken := Gdip_Startup()
	Gdip_SetBitmapToClipboard(pBitmap := Gdip_CreateBitmapFromFile("last1.jpg"))
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
	
	;FilePath := A_WorkingDir . "\" . "Last.jpg"
	
	;FileAppend %filepath% `r`n, *
	
	;fileread clipboard, "last.jpg"

	sleep 20
	send ^v
	FileDelete last1.jpg
	
}
