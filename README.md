# Approach and Architecture Overview

Front-end Application: Angular JS 6 ( http://54.218.38.85 )

* The latest Angularjs version was considered to build front-end Application. Various Components have been created to generate the various pages. For responsiveness Bootstrap 4.0 was used to generate views. Using the concept of services, various REST services have been created for the specific module.

* For example, All the requests concerning to authenticate users, a dedicated service “auth_service” was created. For retrieving user information or any operations related to users the rest requests definations are enclosed in “user_service”

* For user registration purposes, the devise_token_auth system was used and corresponding endpoints have been created at a microservices level which processes the requests from front-end application. The front-end application is designed in such a way that, it is allowed to access only endpoints exposed by Gateway microservice. These definitions are made available via environment variables inside the Angular Application that are used by services built to fire REST Requests.


Gateway Microservice & Auth Microservice:

* Both microservices are Rails API based applications. Since Rails API is bulky to build Restful API’s, using controllers to build API is cluttering in long run and considering the future scope of versioning API i.e. creating newer versions of API or dedicated API for the web, mobile applications a different approach was followed. Both Rails API applications are mounted with lightweight REST API micro-framework called Grape. 

* The advantages are many using this as it totally simplifies the process of building API with inbuilt support for better benchmarks, multiple formats, subdomain/prefix restriction, and versioning.

* This framework defines a straightforward approach to define API with consumable endpoints and provides the ability to use the Rails API features simultaneously. 

* Also, considering development phase problems in a microservice ecosystem where different developers need to communicate about new endpoints points being added & associated mandatory & optional parameters on a timely basis. This time taking process. To avoid this problem, an ability to generate documentation on the fly whenever a new endpoint is defined in the API automatically was implemented on both microservices. 

* Visiting: http://54.218.38.85:3001/docs/#/ (Auth microservice) will directly list out all the endpoints available for each module. This also provides the ability to fire requests immediately and test the endpoint with ease. 

* All the endpoints are versioned as well. So that structure each endpoint was configured. 

For example: Consider the following endpoint.

http://54.218.38.85:3001/api/v1/devise_users/

* 54.218.38.85:3001 - Host information
* “api” - indicates that is an API endpoint
* “v1” - indicates the VERSION of the API
* “devise_users” - endpoint name

* All the microservices contains their own dedicated databases which are created using PostgreSQL.

Gateway Microservice ( http://54.218.38.85:3000/docs/# ): 

* A module “requests” is built to fire all CRUD requests. Whenever a request comes from a front-end application, two parameters “path” & “service” are detected. Using this information, the microservice to which the request needs to be sent will be decided. Along with the decision-making system, the validity of the path is also checked by accessing the “paths” module built into each microservice that is designed to list out all the valid paths using regular expressions for validation. 

* When a path is matched against any valid paths provided by particular microservices, then the path is validated. Also, the authentication of the request is also checked based on the options declared on each path. If a flag “send_user_id” exists in the path information, then the validity of user_id, access token, authentication headers are verified. 

* If the validity of path and access token fails, the gateway microservice terminates the request. The access token is validated via an endpoint named “validate_token”. Front-end will be sending this token where it will be validated at endpoint level and response will be sent back. 


Auth Microservice ( http://54.218.38.85:3000/docs/# ):

* This microservice is aimed to manage users and any features related to users. The basic idea to create a dedicated microservice to manage users.

* The Authentication system is implemented in this microservice and it exposes endpoints that can be used for authorization. As we have a requirement to list out all registered users in the Tech challenge, we will be defining all the endpoints related users in auth microservice. So, an endpoint (/devise_users) was built for this purpose which returns the list of users.

