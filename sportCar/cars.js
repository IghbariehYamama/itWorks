let nextID = 0;
let currentID = 0;
//מחלקה המחזיקה מכונית
class car{

constructor(name, color, year, licenseNum, price, photo)
{
    this.#id = ++nextID; //מספור רץ לפי המשתנה הסטטי שעולה ב-1
    this.name = name;
    this.color = color;
    this.year = year;
    this.licenseNum = licenseNum;
    this.price = price;
    this.photo = photo;
}
    #id; //private
    name;
    color;
    year;
    licenseNum = 0;
    price;
    photo;

    getID()
    {
        return this.#id;
    }

}

let cars = []; //מערך של הרכבים
//פונקציה המוסיפה רכב חדש למערך
function addCar(name, color, year, licenseNum, price, photo)
{
    cars.push(new car(name, color, year, licenseNum, price, photo));
}
//פונקציה המקבלת פרטי רכב מהמשתמש
let createCar = function(){
    //קישור לשדות של הדף
    let name = $('#name');
    let color = $('#color');
    let year = $('#year');
    let licenseNum = $('#licenseNum');
    let price = $('#price');
    let photo = $('#photo');
    //הכנסת רכב חדש לפי הפרטים שהתקבלו מהמשתמש
    addCar(name.val(), color.val(), year.val(), licenseNum.val(), price.val(), photo.val());
    //ניקוי השדות בדף
    name.val("");
    color.val("");
    year.val("");
    licenseNum.val("");
    price.val("");
    photo.val("");
    showCar(cars.length-1);
}
//פונקציה המוחקת רכב
function deleteCar(id)
{
    for(let i=0; i<cars.length; i++)
    {
        if(cars[i].getID === id)
        {
            cars.splice(i, 1); //פקודה החותכת את המערך ממקום האינדקס ב-1
            break;
        }
    }
}

//פונקציה מוצאת מיקום מכונית לפי הקוד
function findLocationByID(id){
    if(cars.length>0)
        for(let i=0; i<cars.length; i++){
            if(cars[i].getID() == id)
                return i;
        }
    return -1;
}

//פונקציה המציגה מכונית קודמת במערך
function back(){
    let location = findLocationByID(currentID);
    if(location>0)
        showCar(location-1);
    else
        showCar(cars.length-1);
}

//פונקציה המציגה מכונית הבאה במערך
function next(){
    let location = findLocationByID(currentID);
    if(location<cars.length-1 && location>=0) 
        showCar(location+1);
    else
        showCar(0);
}

//מציגה מכונית לפי המיקום במערך
let showCar = function(location)
{
    //בדיקה האם יש מכוניות במערך והאם המיקום של המכונית קיים במערך
    if((cars.length > 0) && (cars.length > location))
    {
        $('#existCars').show(); //הצגת הדיב שבתוכו הטבלה המציגה מכונית
       // let table = HTML.createElement('table');//קישור לטבלה
        let table = $('#table');
        if(table.length >= 1){ //בדיקת כמה שורות יש בטבלה
            $('#table tr:last').remove();
        }

        /*
        console.log(table.length);
        if(table.rows.length > 1){
            table.deleteRow(table.rows.length-1);
        }*/
        let tr = document.createElement('tr'); //יצירת שורה חדשה של טבלה
        tr.insertCell().innerHTML = cars[location].name;
        tr.insertCell().innerHTML = cars[location].color;
        tr.insertCell().innerHTML = cars[location].year;
        tr.insertCell().innerHTML = cars[location].licenseNum;
        tr.insertCell().innerHTML = cars[location].price;
        let cell = tr.insertCell(); //יצירת תא שבהמשך נחבר אליו 
        let img = document.createElement('img'); // יצירת אובייקט של תמונה
        img.src = cars[location].photo; //קישור לתמונה מהאינטרנט
        cell.append(img); //הוספת תמונה לתא 
        table.append(tr); //הוספת השורה לטבלה
        currentID = cars[location].getID();
    }
}