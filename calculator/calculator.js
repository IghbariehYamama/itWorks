(($) =>{
    $(document).ready(()=>{
        const buttons =$('button');
        buttons.on('click', function(){number(this.val)});
    })
}

)

function number(num)
{
    document.getElementById("result").value += num;
}

function result(){
    document.getElementById("result").value = eval(document.getElementById("result").value);
}

function empty(){
    document.getElementById("result").value = "";
}

function negative(num)
{
    document.getElementById("result").value *= -1;
}

