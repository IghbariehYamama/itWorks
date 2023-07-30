const re = document.getElementById('mydiv');
ReactDom.render(
    <div>
        <Hello></Hello>
    </div>, re
);

function Hello() {
    return <h1>Hello World!</h1>;
  }

function helloNumber(num){
    let result = '';
    for(let i =0; i<num; i++){
        result += Hello();
    }
    return result;
  }