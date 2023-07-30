//Step 1: Connect
const express = require("express");
const bodyParser = require("body-parser");
const host = express();
var sql = require("mssql");
let { request } = require("express");
const e = require("express");

host.listen(3000, () => {
  console.log("running on port 3000");
});

var Connection = require("tedious").Connection;
var config = {
  server: "LAPTOP-DJIPPDD7",
  authentication: {
    type: "default",
    options: {
      userName: "sa",
      password: "1234",
    },
  },
  options: {
    // If you are on Microsoft Azure, you need encryption:
    encrypt: true,
    database: 'yad2',  //update me
    trustServerCertificate: true,
    trustedConnection: false,
    validateBulkLoadParameters:false,
    rowCollectionOnRequestCompletion:true,
    enableArithAbort: true
}, port : 1433

};
//creat connection class according to what we have in tedious library
//inside the create add config with all the settings
var connection = new Connection(config);
//In connecting time check if there is an error
//event connection
connection.on("connect", function (err) {
  // If no error, then good to proceed.
  if (err) console.log(err);
  console.log("Connected");
  //send to the function to read the select
  executeStatement(); //reading the data from the sql
});

//connecting to DB:
connection.connect();

var Request = require("tedious").Request;
var TYPES = require("tedious").TYPES;
//Step 2: Execute a query
function executeStatement() {
  request = new Request("SELECT * FROM products", function (err) {
    if (err) {
      console.log(err);
    }
  });
  var result = "";
  request.on("row", function (columns) {
    columns.forEach(function (column) {
      if (column.value === null) {
        console.log("NULL");
      } else {
        result += column.value + " ";
      }
    });
    console.log(result);
    result = "";
  });

  request.on("done", function (rowCount, more) {
    console.log(rowCount + " rows returned");
  });

  //gives the advantage of handling the error
  request.callback = function (err, rowCount, rows) {
    // rows is not being set but rowCount is. May be a bug.
    if (err) {
      // Error handling.
    } else {
      // Next SQL statement.
      ("SELECT * FROM courses;");
    }
  };

  // Close the connection after the final event emitted by the request, after the callback passes
  request.on("requestCompleted", function (rowCount, more) {
    connection.close();
  });
  //excute the sql
  connection.execSql(request);
}


function executeStatement2(){
  request = new Request(
    "select * from customers where custoerID = @id_number", function(err,rowCount){
      if(err) console.log(err);
      if(rowCount == 0) console.log("No Customer was Found With this ID Number");
    });
    request.addParameter('id_number', TYPES.VarChar, '211');
    request.on('row', function(columns) {  
      columns.forEach(function(column) {  
        if (column.value === null) {  
          console.log('NULL');  
        } else {  
          console.log("Product id of inserted item is " + column.value);  
        }  
      });  
  });

  // Close the connection after the final event emitted by the request, after the callback passes
        request.on("requestCompleted", function (rowCount, more) {
            connection.close();
        });
        connection.execSql(request);

  }
