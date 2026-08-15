# Inventory SaaS

Inventory SaaS is an inventory management system designed for small businesses.

It allows businesses to manage products, suppliers, categories, purchases, stock, and inventory movements while maintaining a complete history of inventory changes.

The system also includes user authentication and roles, stock alerts, search and filtering, and product imports through Excel and CSV files.

---

## Tech Stack

### Backend

- **Java 25** — Main backend programming language.
- **Spring Boot** — Backend framework.
- **Spring Web** — REST API development.
- **Spring Data JPA** — Database access and repositories.
- **Hibernate** — ORM for mapping Java entities to database tables.
- **Spring Security** — Authentication and role-based authorization.
- **JWT + HttpOnly Cookies** — Authentication and session handling.
- **Jakarta Validation** — Request and data validation.
- **Maven** — Dependency management and build automation.

### Database

- **PostgreSQL** — Relational database.
- **Flyway** — Database migrations and schema versioning.

### File Import

- **Apache POI** — Excel file processing.
- **Apache Commons CSV** — CSV file processing.

### API Documentation

- **OpenAPI / Swagger** — REST API documentation and testing.

### Testing

- **JUnit 5** — Java testing framework.
- **Mockito** — Unit testing and mocking.
- **Testcontainers** — Integration testing with PostgreSQL containers.

### Frontend

- **React** — User interface.
- **Tailwind CSS** — Styling.
- **Axios** — Communication with the REST API.

### Infrastructure

- **Docker** — Application containerization.
- **Docker Compose** — Runs the application services together.

---

## Project Structure

```text
Inventory_SaaS/
│
├── backend/
│   ├── src/
│   ├── pom.xml
│   ├── mvnw
│   ├── mvnw.cmd
│   └── README.md
│
├── frontend/
│   └── README.md
│
├── docker-compose.yml
└── README.md
```

The `backend` and `frontend` directories contain their own documentation with setup, configuration, and development information specific to each application.

---

## Main Features

- Product management
- Supplier management
- Category management
- Purchase management
- Inventory entries and exits
- Inventory movement history
- Stock monitoring and alerts
- User authentication and roles
- Role-based authorization
- Search, filters, and pagination
- Excel and CSV product imports

---

## Development Workflow

Development is done using separate branches for each feature, fix, or change.

The `main` branch should contain stable and reviewed code. Development should not be done directly on `main`.

### Before Starting

Before starting a new task, switch to `main` and get the latest changes:

```bash
git checkout main
git pull
```

Then create a new branch:

```bash
git checkout -b <type>/<name>
```

---

### Branch Naming

Branches should use a prefix that describes the type of work being done.

```text
feature/    New functionality
fix/        Bug fixes
refactor/   Code restructuring without changing behavior
docs/       Documentation changes
test/       Tests
chore/      Configuration or maintenance
```

Examples:

```text
feature/products
feature/purchases
feature/auth
fix/stock-calculation
refactor/product-service
docs/backend-readme
test/product-service
chore/flyway-config
```

---

### Commits

Commit messages should clearly describe the change.

Use the following format:

```text
<type>: <description>
```

Common commit types:

```text
feat      New functionality
fix       Bug fix
refactor  Code restructuring
docs      Documentation
test      Tests
chore     Configuration or maintenance
```

Examples:

```text
feat: add product creation endpoint
feat: add supplier management
fix: prevent negative stock
refactor: simplify product service
docs: update backend setup
test: add product service tests
chore: configure flyway
```

---

### Finishing a Task

Once the work is finished:

```bash
git status
git add .
git commit -m "feat: add product management"
```

Push the branch:

```bash
git push -u origin feature/products
```

Then create a **Pull Request** to merge the branch into `main`.

The general workflow is:

```text
main
 │
 ├── feature/products
 │       │
 │       ├── commits
 │       │
 │       └── Pull Request
 │               ↓
 │              main
 │
 ├── feature/purchases
 │       │
 │       ├── commits
 │       │
 │       └── Pull Request
 │               ↓
 │              main
 │
 └── fix/stock-calculation
         │
         ├── commits
         │
         └── Pull Request
                 ↓
                main
```

Avoid committing or developing features directly on `main`.

---

## Documentation

Specific setup and development instructions are documented inside each part of the project.

```text
Inventory_SaaS/
│
├── README.md
│
├── backend/
│   └── README.md
│
└── frontend/
    └── README.md
```

### Backend

The backend documentation contains information about:

- Java and Spring Boot configuration
- Feature-based backend architecture
- PostgreSQL configuration
- `application.properties`
- Maven Wrapper
- Flyway migrations
- Database versioning
- Running the backend locally

### Frontend

The frontend documentation will contain information about:

- React configuration
- Tailwind CSS
- Axios
- Frontend project structure
- Environment configuration
- Running the frontend locally