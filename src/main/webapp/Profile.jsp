<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%
	response.setHeader("cache-Control","no-cache, no-store, must-revalidate");
%>
    <meta charset="ISO-8859-1">
    <title>Update Profile</title>
    <link rel="stylesheet" href="main.css">
    <link rel="shortcut icon" href="images/sp.jfif">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <style>
        /* General body styles */
        body {
           margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-wrap: wrap;
            font-size:18px;
            font-family: 'Comic Sans MS', cursive, sans-serif;
            background: linear-gradient(135deg, #1A1A1A 30%, #E50914 70%);
             height:128vh;
        
        }

       nav#sidebar {
        width: 250px;
        background: linear-gradient(135deg, #1c1c1c 50%, #00294b 50%);
        padding: 10px 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        color: #fff;
    }

    nav#sidebar img.logo-circle {
        width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
            border: 2px solid #FFFFFF;
    }

    nav#sidebar .user {
        margin-top: 20px;
        color:white;
        font-weight:bold;
        text-align:center;
    }

    nav#sidebar .user label {
        display: block;
    }

    nav#sidebar ul {
        list-style: none;
        padding: 0;
        width: 100%;
    }

    nav#sidebar ul li {
        width: 88%;
        padding: 15px;
        text-align: center;
        cursor: pointer;
        transition: background 0.3s;
    }

    nav#sidebar ul li:hover {
        background: rgba(255, 255, 255, 0.2);
    }

    nav#sidebar ul li.active {
        background: white;
        color: deepskyblue;
    }

    nav#sidebar ul li a {
        color: inherit;
        text-decoration: none;
    }
        /* Container for the form */
        .profile-form-container {
            background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent white background */
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            width: 400px;
            text-align: center;
            position: relative;
            border: 5px solid #FFD700; /* Golden border for a playful, treasure-like effect */
            margin: auto; /* Center form */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        /* Centering all form elements */
        form {
            display: flex;
            flex-direction: column;
            width: 100%;
            align-items: center;
        }

        /* Heading style */
        h1 {
            margin-bottom: 20px;
            font-size: 28px;
            color: #FF4500; /* Fun, energetic orange */
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2); /* Add shadow for a 3D effect */
        }

        /* Label styles */
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
            text-align: left;
            font-size: 18px;
            width: 100%; /* Make the labels span the width of the form */
        }

        /* Input field styles */
        input[type="text"],
        input[type="number"],
        input[type="file"] {
            width: 100%; /* Make input fields span 100% of the form width */
            padding: 12px;
            margin-bottom: 20px;
            border: 3px solid #FF4500; /* Fun, thick borders */
            border-radius: 10px;
            font-size: 18px;
            background-color: #FFFACD; /* Light yellow background for inputs */
            transition: border-color 0.3s;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        input[type="file"]:focus {
            border-color: #32CD32; /* Lime green when focused */
            outline: none;
        }

        /* Submit button styles */
        input[type="submit"] {
            width: 100%;
            background-color: #32CD32; /* Bright lime green for fun energy */
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        input[type="submit"]:hover {
            background-color: #228B22; /* Darker green on hover */
            transform: scale(1.05); /* Fun zoom effect on hover */
        }

        /* Home button styles */
        .home-button {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            align-items: center;
            color: #333;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 15px;
            border-radius: 10px;
            background-color: #FFFACD; /* Light yellow background */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
            transition: background-color 0.3s, transform 0.2s;
        }

        .home-button:hover {
            background-color: #FFD700; /* Gold on hover */
            transform: scale(1.1); /* Slightly enlarge on hover */
        }

        /* Arrow for the home button */
        .home-button .arrow {
            margin-right: 10px;
            display: inline-block;
            width: 12px;
            height: 12px;
            border-left: 3px solid #333;
            border-bottom: 3px solid #333;
            transform: rotate(45deg);
        }

        /* Responsive design */
        @media (max-width: 500px) {
            .profile-form-container {
                width: 90%;
            }
        }
    </style>

</head>
<body>

    <nav id="sidebar">
        <img src="<%= session.getAttribute("image") != null ? "uploads/" + session.getAttribute("image") : "images/default.jpg" %>" alt="Profile Picture" class="logo-circle">
        <div class="user">
            <label class="uname">UserName :- 
                <% 
                    String fname = (String) session.getAttribute("fname");
                    if (fname != null) {
                        out.print(fname); // Display the value
                    } else {
                        out.print("Name not available"); // Fallback message if session is null
                    } 
                %>
            </label><br>
            <label class="unumber">Contact No :-<% 
                    String contact = (String) session.getAttribute("contact");
                    if (contact != null) {
                        out.print(contact); // Display the contact number
                    } else {
                        out.print("Not available"); // Fallback message if contact number is null
                    } 
                %></label>
        </div>
        
        <ul class="group">
            <li><a href="Dashboard.jsp"><i class="material-icons"></i>Home</a></li>
            <li><a href="Wallet.jsp"><i class="material-icons"></i>Wallet</a></li>
            <li><a href="Privacy.jsp"><i class="material-icons"></i>Privacy Policy</a></li>
            <li><a href="TermsCondition.jsp"><i class="material-icons"></i>Terms & Condition</a></li>
            <li class="active"><a href="Profile.jsp"><i class="material-icons"></i>Profile Update</a></li>
            <li><a href="Logout.jsp" id="logoutButton"><i class="material-icons"></i>LogOut</a></li>
        </ul>
        <img src="images/spin.png" alt="vflyorions" width="250px" height="150px">
    </nav>

    <div class="profile-form-container">
        <h1>Update Profile</h1>
        <br>
        <form action="UserUpdate.jsp" method="post" enctype="multipart/form-data">
            <!-- Hidden field to pass the user ID -->
            <input type="text" name="userID" value="<%= session.getAttribute("userID") %>" placeholder="Enter Id">

            <label for="fname">UserName</label>
            <input type="text" id="fname" name="fname" value="<%= session.getAttribute("fname") %>">
			
            <label for="phone">Phone</label>

			<input class="in" type="number" name="phone" value="<%= session.getAttribute("contact") %>" placeholder="Phone Number*" required id="phone" min="0" oninput="validatePhoneNumber()">
            <input type="submit" value="Update">
        </form>
    </div>
  <script>
        // Disable browser back button functionality
        window.history.pushState(null, null, window.location.href);
        window.onpopstate = function() {
            window.history.pushState(null, null, window.location.href);
        };

        // Add event listener to the logout button
        document.getElementById("logoutButton").addEventListener("click", function(event) {
            event.preventDefault(); // Prevent the default action of the link
            Swal.fire({
                title: 'Are you sure?',
                text: "Once You Logout your data is not visible",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, log me out!'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Redirect to a logout servlet or JSP that handles session invalidation
                    window.location.href = 'Logout.jsp'; // Create this servlet
                }
            });
        });
        function validatePhoneNumber() {
		    var phoneInput = document.getElementById("phone");
		
		  
		    if (phoneInput.value.length > 10) {
		     
		        phoneInput.value = phoneInput.value.slice(0, 10);
		   
		        alert("Phone number limit is 10 digits only.");
		    }
		}
    </script>
</body>
</html>
