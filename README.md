<!-- TABLE OF CONTENTS -->
<h3>
  <details>
    <summary>Table of Contents</summary>
    <ol>
      <li>
        <a href="#about-the-project">About The Project</a>
        <ul>
          <li><a href="#built-with">Built With</a></li>
          <li><a href="#database-schema">Database Schema</a></li>
        </ul>
      </li>
      <li>
        <a href="#getting-started">Getting Started</a>
        <ul>
            <li><a href="#repository">Repository</a></li>
            <li><a href="#repository-installation">Repository Installation</a></li>
            <li><a href="#endpoints">Endpoints</a></li>
        </ul>
      </li>
      <li><a href="#roadmap">Roadmap</a></li>
      <li><a href="#contact">Contact</a></li>
      <li><a href="#acknowledgments">Acknowledgments</li>
    </ol>
  </details>
</h3>

<!-- ABOUT THE PROJECT -->
## About The Project

Lunch and Learn is a school project at Turing School of software and design with the goal of learning and practicing the following:
1. Exposing an API that aggregates data from multiple external APIs
2. Exposing an API that requires an authentication token
3. Exposing an API for CRUD functionality
4. Determining completion criteria based on the needs of other developers
5. Testing both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
<br />
Wireframes that the imaginary frontend developers would be using, as well as more information can be found in this <a href="https://backend.turing.edu/module3/projects/lunch_and_learn/requirements">link</a> 

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- Built With -->
### Built With

Lunch and Learn is a Rails web API application that relies on aggregating data from the following APIs/services:
1. Restcountries: https://restcountries.com/#api-endpoints-v2-all
2. Edamame: https://developer.edamam.com/edamam-recipe-api
3. Pexels: https://www.pexels.com/api
4. Youtube Data API: https://developers.google.com/youtube/v3/docs/search/list?apix

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- Database Schema -->
### Database Schema

Lunch and Learn utilizes a one-to-many relationship to organize the user's favorites.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

Lunch and Learn is not meant to be a standalone application; it is built to meet specifically the needs of imaginary frontend developers as mentioned in the about section. For more information, visit: https://backend.turing.edu/module3/projects/lunch_and_learn/requirements

<!-- Repository -->
### Repository

If by some happenstance you're uncertain how you got to this repo, here's the link:
* https://github.com/msakr21/lunch-and-learn <br />

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- Repository Installation -->
### Repository Installation
<b>Gem Installation</b>
* `bundle install`
* `bundle exec figaro install`

<b>DB Creation</b>
* `rails db:{drop,create,migrate}`

<b>Required API keys</b>: 
* Sign up for <a href="https://developer.edamam.com/edamam-recipe-api">Edamam's ID and key</a> and set `EDAMAM_ID and EDAMAM_KEY: <your_ID> and <your_key>, respectively` in `application.yml` 
* Sign up for a <a href="https://www.pexels.com/api">Pexels Authentication token</a> and set `NOT_UNSPLASH(sorry, not sorry): <your_token>` in `application.yml` 
* Create a google api key via the google console: <a href="https://blog.hubspot.com/website/how-to-get-youtube-api-key">tutorial</a>, and set `GOOGLE_API_KEY: <your_key>` in `application.yml`

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- Endpoints -->
### Endpoints

As of the most recent PR, this API has 6 endpoints:<br />
1. get '/api/v1/recipes' which aggregates data from Edamam and RestCountries
2. get '/api/v1/learning_resources' which aggregates data from Pexel and Youtube
3. post '/api/v1/users' which generates a user on the backend and assigns them a randomly generated api_key
4. post '/api/v1/favorites' which allows user with valid key to favorite a recipe
5. get '/api/v1/favorites' which returns a list of favorite recipes with information about each one
6. delete '/api/v1/favorites' which allows the deletion of a favorite
<br />

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

MVP
* [x] Implement API call to Edamam API for recipes by country
* [x] Implement API call to RestCountries for list of country 
* [x] Implement API call to Pexels for images of country
* [x] Implement API call to Youtube's Mr. History channel for informational video on country
* [x] Set up GET '/api/v1/recipes'
* [x] Set up GET '/api/v1/learning_resources'endpoint
* [x] Set up POST '/api/v1/users'
* [x] Set up POST '/api/v1/favorites'
* [x] Set up GET '/api/v1/favorites'

Stretch Goals
* [ ] Implement authentication using bcrypt
* [x] Implement favorite delete functionality
* [ ] Implement background workers or caching to optimize API calls
* [ ] For the recipes and learning resources endpoints, use the REST Countries API to validate that the country parameter passed in is in fact a valid country. If it isn’t, return an appropriate 400-level status code.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

<table>
  <tr>
    <td><img src="https://avatars.githubusercontent.com/u/110377741?s=150&v=4" width='150'></td>
  </tr>
  <tr>
    <td>Mostafa Sakr</td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/msakr21">GitHub</a><br>
      <a href="https://www.linkedin.com/in/mostafa-sakr-4bb722250">LinkedIn</a>
    </td>
  </tr>
</table>

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Turing School of Software Design: [https://turing.edu/](https://turing.edu/)

<p align="right">(<a href="#top">back to top</a>)</p>
