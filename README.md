# Inventory SaaS

Inventory SaaS is an inventory management system for small businesses. It allows businesses to manage products, suppliers, categories, purchases, stock, and inventory movements while keeping a complete history of inventory changes.

The system also includes user roles, stock alerts, search and filtering, and product imports through Excel and CSV files.

## Architecture

The backend follows a **Layered Architecture**, separating responsibilities into:

```text id="u1m8qc"
Controller
    ↓
Service
    ↓
Repository
    ↓
Database
```

* **Controller** — Handles HTTP requests and API responses.
* **Service** — Contains the business logic and inventory rules.
* **Repository** — Handles database access.
* **Entity** — Represents the application's database entities.
* **DTO** — Transfers data between the API and the application.
* **Security** — Handles authentication and authorization.

## Tech Stack

### Backend

* **Java 21** — Main backend programming language.
* **Spring Boot** — Backend framework.
* **Spring Web** — REST API development.
* **Spring Data JPA** — Database access and repositories.
* **Hibernate** — ORM for mapping Java entities to database tables.
* **Spring Security** — Authentication and role-based authorization.
* **JWT + HttpOnly Cookies** — Authentication and session handling.
* **Jakarta Validation** — Request and data validation.
* **Maven** — Dependency management and build automation.

### Database

* **PostgreSQL** — Relational database.
* **Flyway** — Database migrations and schema versioning.

### File Import

* **Apache POI** — Excel file processing.
* **Apache Commons CSV** — CSV file processing.

### API Documentation

* **OpenAPI / Swagger** — REST API documentation and testing.

### Testing

* **JUnit 5** — Java testing framework.
* **Mockito** — Unit testing and mocking.
* **Testcontainers** — Integration testing with PostgreSQL containers.

### Infrastructure

* **Docker** — Application containerization.
* **Docker Compose** — Runs the frontend, backend, and PostgreSQL services together.

### Frontend

* **React** — User interface.
* **Tailwind CSS** — Styling.
* **Axios** — Communication with the REST API.

## Project Structure

```text id="mqsg8o"
Inventory_SaaS/
├── backend/
├── frontend/
├── docker-compose.yml
└── README.md
```

## Main Features

* Product, supplier, and category management
* Purchase management
* Inventory entries and exits
* Inventory movement history
* Stock monitoring and alerts
* User authentication and roles
* Search, filters, and pagination
* Excel and CSV product imports
