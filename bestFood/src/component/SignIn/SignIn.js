import React from "react"
import './SignIn.css'


function SignIn(){

    return (
        <div>

        <h1> Sign In</h1>
        <form>
            <input
          type="text" placeholder="Full Name"></input>
           <input
          type="text" placeholder="Email"></input>
          
          <br></br>
            
        <button type="submit">Submit</button>

        </form>

        </div>
    )

}

export default SignIn ;
