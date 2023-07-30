import React from 'react';
//importing the components i have created //
import Header from './Header/Header';
import SignIn from './SignIn/SignIn';
import SignUp from './SignUp/SignUp';
//importing use state // 
import { useState } from 'react';


function App() {

  const [choice , choiceUpdate] = useState(false) //user hook to update the page without refresh 
  
  
  function SignUpchoice(){ // function to set up the choice
    choiceUpdate(false)
  }
  function SignInchoice(){
    choiceUpdate(true) 
  }

  /*{choice ? <SignIn/> : <SignUp/>} this in the returns means if the choice is true return the sign
  in page else return the sign up page  ( ternary operator )*/ 

  return (
    <div className="container">
     
       <Header />
       <br></br>
       <div className='choices'><button onClick={SignInchoice} type="submit">Sign In</button> <button  onClick={SignUpchoice} type="submit">Sign Up</button> </div>
       {choice ? <SignIn/> : <SignUp/>} 

    </div>
  );
}

export default App;
