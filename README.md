<!-- PROJECT DESCRIPTION -->

# 📖 Contractor Connect API

This API is an ongoing project. It serves as the back-end for a full-stack project that allows users to create accounts and make reservations with contractors. Here is the <a href="https://github.com/emyrue/contractor-front-end">link</a> to the front-end repository.

## 🛠 Built With

### Tech Stack

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

<!-- Features -->

### Key Features

- Account creation/modification using Devise gem
- JWT allows user to remain signed in for two weeks
- User may register as a contractor
- User may become an admin by entering a secret code
- Users may make and edit reservations with contractors
- Users can leave reviews on contractors
- Users may like or dislike reviews on contractors

<!-- GETTING STARTED -->

## 💻 Getting Started

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

- Ruby version 3.2.1
- Rails version >= 7.0.4.3
- PostgreSQL version 14.8

### Setup

Clone this repository to your desired folder by running the following command:

- git clone git@github.com:emyrue/contractor_api.git

You will need to create your own encrypted credentials file and add these values:

- devise_jwt_secret_key
- sendmail_password
- sendmail_username
- frontend_app_url
- admin_code

You will also need to create your own git-ignored master.key file.
The sendmail_password and sendmail_username will have to be set up in gmail.

### Install

Install this project with:

- cd contractor_api
- bundle install
- rails db:create
- rails db:migrate

### Usage

To run the project, execute the following command:

- rails s -p 4000

### Run tests

Tests are not yet in place. Check back for updates.

<!-- AUTHORS -->

## 👥 Authors

👤 **Emily Robertson**

- GitHub: [@emyrue](https://github.com/emyrue)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/emilyruthrobertson/)

<!-- FUTURE FEATURES -->

## 🔭 Future Features

- Mailer sends confirmation emails
- Reset password
- Mailer sends notification emails regarding reservation approvals, updates, and rejections
- Admin privileges, such as viewing and managing others' account information

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<!-- LICENSE -->

## 📝 License

This project is [MIT](./MIT.md) licensed.