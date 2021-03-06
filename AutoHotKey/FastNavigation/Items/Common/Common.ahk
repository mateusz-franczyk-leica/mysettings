#Include %A_ScriptDir%\Common\Guid\GuidFormatter.ahk
#Include %A_ScriptDir%\FastNavigation\Items\Common\SeparatorMenuItem.ahk
#Include %A_ScriptDir%\FastNavigation\Items\Common\WindowTitleParser.ahk
#Include %A_ScriptDir%\FastNavigation\Items\Common\CopyPropertyMenuItem.ahk
#Include %A_ScriptDir%\FastNavigation\Items\Common\Guid\GuidMenuItem.ahk
#Include %A_ScriptDir%\FastNavigation\Items\Common\Guid\GuidFormatMenuItem.ahk
#Include %A_ScriptDir%\FastNavigation\Items\Common\EnvironmentNavigationItem.ahk


GetGuidFormat(letter){
    guidMenu := new GuidMenuItem(letter, "Format guid from clipboard")
        .AddItem(new GuidFormatMenuItem("b", GuidFormatter.BFormat))
        .AddItem(new GuidFormatMenuItem("d", GuidFormatter.DFormat))
        .AddItem(new GuidFormatMenuItem("n", GuidFormatter.NFormat))
        .AddItem(new GuidFormatMenuItem("x", GuidFormatter.XFormat))
        
    return guidMenu
}


class TranslateItem extends NavigationItem {
    __New(letter){
        this.UrlFormat := "https://translate.google.com/?rlz=1C1CHBF_enPL813PL813&um=1&ie=UTF-8&hl=pl&client=tw-ob#view=home&op=translate&sl=en&tl={1}&text={2}"
        base.__New(letter, "Translate word from english to ...")
    }

    ActivateItem(){
        InputBox, WordToTranslate, Insert Word to translate
        InputBox, Language, Insert destination language

        url := Format(this.UrlFormat, Language, WordToTranslate)
        Chrome(url)
    }
}

class TimeItem extends NavigationItem {

    __New(letter, timeZone){
        base.__New(letter, guidFormat)
        this.TimeZone := timeZone
    }

    FormatGuid(){
        guidToFormat := this.Parent.GuidToFormat
        Log("GUid to format {1}, format {2}", [guidToFormat, this.GuidFormat])
        formatted := this.GuidFormatter.Format(guidToFormat, this.GuidFormat)
        return formatted
    }

    ActivateItem(){
        formatted := this.FormatGuid()
        Clipboard:= formatted
        ;SendInput {Raw}%formatted%
    }

    FormatItemText(){
        guidText := this.FormatGuid()
        return Format("{1} - {2}", this.letter, guidText)
    }
}
