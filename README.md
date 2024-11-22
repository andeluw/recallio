# Recallio Flashcard App

Recallio is a flashcard app built using Java Server Pages (JSP) and Servlets. It allows users to create and manage flashcard decks, track their learning progress, and study various topics using flashcards. This project was created to fulfill the 2nd quiz of the Web Programming F course.


## Setup Instructions

To replicate and run this project, please follow the steps below:

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/andeluw/recallio.git
```

### 2. Setup Environment Variables

Set the necessary environment variables. The environment configuration files are located in the /src/main/resources folder.

```
DB_HOST=
DB_PORT=
DB_NAME=
DB_USERNAME=
DB_PASSWORD=
```

### 3. Database Setup

To set up the database, create the necessary tables using the scripts provided in `/src/main/resources/db_migrations`. Sample data for seeding is available in `/src/main/resources/db_seeder`.

### 4. Running the Application

Build the project

```bash
mvn clean install
```

Deploy the project to Tomcat. You can either:

- Use the Maven Tomcat plugin:
  
```bash
mvn tomcat7:deploy
```

- Deploy manually by copying the `.war` file to the webapps directory of your Tomcat server.

Access at

```
http://localhost:8080/recallio
```
