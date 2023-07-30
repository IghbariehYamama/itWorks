function choice(minute)
{
    //פונקציה שמטפלת בבחירה של המשתמש
    //מקבל את כפתור הבחירה ומכניס ערך לפי מה שקיבל בפונקציה
    document.getElementById("mySelect").value = minute;
    select(minute);
}

function select(val)
{
    let father = document.getElementById("timers");
    //ריצה על כל הילדים של הדיב הראשי
    for(let i = 0; i<father.children.length; i++)
    {
        father.children[i].style.display="none";
    }

    document.getElementById('timer'+val).style.display="";
/*
    switch (val) {
        case 10:
            document.getElementById("timer10").style.display = "";
            break;
        case 15:
            document.getElementById("timer15").style.display = "";
            break;
        case 20:
            document.getElementById("timer20").style.display = "";
            break;
        default:
            document.getElementById("timer40").style.display = "";
            break;
    }
*/
}
$(document).ready(function()
{
    select(10);
}
);