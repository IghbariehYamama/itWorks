import React from 'react'
import './SignUp'

function SignUp(){

    return (<div>

        <h1> Sign Up</h1>
        <form>
            <input type="text" placeholder="Full Name"></input>
           <input type="text" placeholder="Email"></input>
           <input type="text" placeholder="Username"></input>
           <input type="text" placeholder="ID"></input>
           <input type="text" placeholder="Password"></input>
          
          
          <br></br>
            
        <button type="submit">Submit</button>

        </form>

        </div>)

}
export default SignUp ;