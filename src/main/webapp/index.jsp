<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Digital Notice Board | DNB</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    body {
      margin: 0;
      font-family: 'Roboto', sans-serif;
      background-color: #fff;
    }
    nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 2rem;
      background: white;
      position: sticky;
      top: 0;
      z-index: 1000;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
      height:60px;
    }
    nav .logo {
      font-size: 1.5rem;
      color: #ff6600;
      font-weight: bold;
    }
    nav .menu {
      display: flex;
      gap: 1.5rem;
    }
    nav .menu a {
      color: #333;
      text-decoration: none;
      font-weight: 500;
    }
    nav .menu .btn {
      background: #ff6600;
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 5px;
      text-decoration: none;
      padding:15px;
    }
    .hero {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 4rem 10%;
      background-color: #f9f9f9;
      min-height: auto; /* Adjusted to auto to accommodate content */
      flex-wrap: wrap; /* Allow items to wrap on smaller screens */
    }
    .hero .text {
      max-width: 50%;
      flex-basis: 50%; /* Take up 50% width initially */
    }
    .hero h1 {
      font-size: 3rem;
      margin-bottom: 1rem;
      font-weight: 800;
      color: #1a1a1a;
    }
    .hero p {
      font-size: 1.2rem;
      margin-bottom: 2rem;
      color: #5f6368;
    }
    .hero .btn {
      background: #ff6600;
      color: white;
      padding: 1rem 2rem;
      border: none;
      border-radius: 5px;
      font-size: 1rem;
      text-decoration: none;
    }
    .hero-image {
      box-sizing: border-box;
      height: auto;
      max-width: 50%;
      flex-basis: 50%; /* Take up 50% width initially */
      vertical-align: middle;
    }
    .card-container {
      display: grid;
      grid-template-columns: repeat(2, 1fr); /* 2 cards in a row */
      gap: 20px;
      margin-top: 4rem;
      max-width: 1000px;
      margin-left: auto;
      margin-right: auto;
      padding: 20px;
    }


    .card {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
      padding: 20px;
      text-align: center;
    }

    .card i {
      font-size: 2rem;
      color: #ff6600;
      margin-bottom: 10px;
    }

    .card h3 {
      font-size: 1.5rem;
      margin-bottom: 10px;
      color: #333;
    }

    .card p {
      font-size: 1rem;
      color: #555;
      line-height: 1.4;
       text-align: justify;
    }

    /* Media query for smaller screens */
    @media (max-width: 768px) {
      .hero {
        flex-direction: column;
        text-align: center;
        padding: 2rem 5%;
      }
      .hero .text {
        max-width: 100%;
        flex-basis: 100%;
        margin-bottom: 2rem;
      }
      .hero-image {
        max-width: 80%;
        flex-basis: 100%;
        margin-top: 2rem;
      }
      .card-container {
        margin-top: 2rem; /* Adjust card margin on smaller screens */
        padding: 10px;
      }
    }

  footer {
      background: black;
      color: white;
      text-align: center;
      padding: 1.5rem;
      width: 100%;
  }
  </style>
</head>
<body>
  <nav>
    <div class="logo"><i class="fas fa-quote-right"></i> DNB</div>
    <div class="menu">
      <a href="register.jsp" class="btn">Register</a>
      <a href="login.jsp" class="btn">Login-in</a>
    </div>
  </nav>

  <section class="hero">
    <div class="text">
      <p style="color: #f26522; font-weight: bold;">DIGITAL NOTICE BOARD</p>
      <h1>Convey information <br />dynamically</h1>
      <p>Transform how you share crucial information and updates with your audience with a digital notice board. Ensure your messages are not only seen but also impactful.</p>
      <a href="login.jsp" class="btn">Get Started</a>
    </div>
    <img src="TV-Screen-2.png" alt="Digital Notice Board Example" class="hero-image">
  </section>

  <section class="benefits">
    <div class="card-container">
      <div class="card">
        <i class="fas fa-tv"></i>
        <h3>Dynamic content</h3>
        <p>An electronic notice board allows for dynamic content updates. Unlike static bulletin boards, information on digital notice boards can be easily updated to meet the specific needs of the audience.</p>
      </div>
      <div class="card">
        <i class="fas fa-bullhorn"></i>
        <h3>Emergency alerts</h3>
        <p>An electronic notice board can be utilized for emergency alerts, ensuring crucial information is swiftly disseminated to guarantee your audience's safety promptly.</p>
      </div>
      <div class="card">
        <i class="fas fa-pencil-ruler"></i>
        <h3>Customization</h3>
        <p>Customize the digital information board's layout, colors, and design to seamlessly align with your organization's unique branding or theme, creating engaging displays.</p>
      </div>
      <div class="card">
        <i class="fas fa-hand-pointer"></i>
        <h3>Interactivity</h3>
        <p>Use touchscreens or interactive displays and enable users to engage with the content, providing a more immersive and personalized experience.</p>
      </div>
    </div>
  </section>

  <footer>
    <p>&copy; 2025 Digital Notice Board | Powered by DNB</p>
  </footer>
</body>
</html>