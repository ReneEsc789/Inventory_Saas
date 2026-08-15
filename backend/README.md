# Backend — Inventory SaaS

Backend del sistema de gestión de inventarios desarrollado con **Java 25 y Spring Boot**.

## Tecnologías

- Java 25
- Spring Boot
- Maven
- Spring Web
- Spring Data JPA
- Spring Security
- Bean Validation
- PostgreSQL
- Flyway

---

# Arquitectura

El backend utiliza una **arquitectura vertical por funcionalidades**.

En lugar de separar toda la aplicación en carpetas globales como:

```text
controller/
service/
repository/
entity/
```

cada funcionalidad del sistema mantiene sus propios componentes.

La estructura crecerá aproximadamente de la siguiente manera:

```text
src/main/java/com/inventorysaas/
│
├── BackendApplication.java
│
├── config/
│
├── categoria/
│   ├── Categoria.java
│   ├── CategoriaController.java
│   ├── CategoriaService.java
│   ├── CategoriaRepository.java
│   └── dto/
│
├── proveedor/
│   ├── Proveedor.java
│   ├── ProveedorController.java
│   ├── ProveedorService.java
│   ├── ProveedorRepository.java
│   └── dto/
│
├── producto/
│   ├── Producto.java
│   ├── ProductoController.java
│   ├── ProductoService.java
│   ├── ProductoRepository.java
│   └── dto/
│
├── compra/
│   └── ...
│
├── inventario/
│   └── ...
│
└── usuario/
    └── ...
```

Esto permite mantener en un mismo módulo todo lo relacionado con una funcionalidad.

Por ejemplo:

```text
producto/
│
├── Producto.java
├── ProductoController.java
├── ProductoService.java
├── ProductoRepository.java
└── dto/
```

Todo lo relacionado con productos se encuentra dentro de `producto/`.

---

# Requisitos

Para ejecutar el backend se necesita:

- Java JDK 25
- PostgreSQL

No es necesario instalar Maven manualmente porque el proyecto incluye **Maven Wrapper**.

Para verificar la versión de Java:

```bash
java --version
```

Debe utilizarse Java 25.

---

# Configuración de PostgreSQL

El backend utiliza una base de datos PostgreSQL llamada:

```text
inventory_saas
```

Antes de ejecutar el backend debe existir esta base de datos.

Puede crearse desde pgAdmin o `psql`:

```sql
CREATE DATABASE inventory_saas;
```

La base de datos debe crearse **vacía**.

No deben ejecutarse manualmente los `CREATE TABLE` del proyecto.

La creación y actualización de las tablas es responsabilidad de **Flyway**.

---

# Configuración de `application.properties`

Dentro de:

```text
src/main/resources/
```

se encuentra:

```text
application.properties.example
```

Este archivo sirve como plantilla de configuración.

Cada desarrollador debe crear su propio:

```text
application.properties
```

a partir del archivo de ejemplo.

La estructura es:

```text
src/main/resources/
│
├── application.properties.example
└── application.properties
```

`application.properties.example` contiene la configuración necesaria sin credenciales personales.

Por ejemplo:

```properties
spring.application.name=backend

spring.datasource.url=jdbc:postgresql://localhost:5432/inventory_saas
spring.datasource.username=TU_USUARIO
spring.datasource.password=TU_PASSWORD

spring.jpa.show-sql=true
```

Después de copiarlo a `application.properties`, cada desarrollador debe colocar sus propias credenciales de PostgreSQL:

```properties
spring.datasource.username=postgres
spring.datasource.password=CONTRASEÑA_LOCAL
```

El archivo `application.properties` es local para cada desarrollador.

---

# Base de datos y Flyway

El backend utiliza **Flyway** para administrar y versionar la estructura de PostgreSQL.

Las migraciones se encuentran en:

```text
src/main/resources/db/migration/
```

Actualmente la primera versión del esquema se encuentra en:

```text
V1__schema.sql
```

La estructura es:

```text
src/main/resources/
│
├── db/
│   └── migration/
│       └── V1__schema.sql
│
├── application.properties.example
└── application.properties
```

Cuando Spring Boot inicia, Flyway busca automáticamente las migraciones disponibles.

En una base de datos nueva:

```text
Spring Boot
    ↓
Flyway
    ↓
V1__schema.sql
    ↓
PostgreSQL
    ↓
Creación de las tablas
```

Por esta razón solamente debe crearse `inventory_saas`.

Las tablas **no deben crearse manualmente**.

Flyway también crea automáticamente la tabla:

```text
flyway_schema_history
```

Esta tabla registra qué versiones de la base de datos ya fueron ejecutadas.

---

# Modificaciones de la base de datos

Una migración que ya fue aplicada no debe modificarse.

Por ejemplo, si existe:

```text
V1__schema.sql
```

y posteriormente necesitamos modificar la base de datos, **no modificamos `V1__schema.sql`**.

Se crea una nueva migración.

Por ejemplo, si necesitamos agregar `codigo` a `productos`:

```text
V2__add_codigo_producto.sql
```

Contenido:

```sql
ALTER TABLE productos
ADD COLUMN codigo VARCHAR(50);
```

Las migraciones siguen el formato:

```text
V<version>__<descripcion>.sql
```

Es importante utilizar **dos guiones bajos `__`** entre la versión y la descripción.

Ejemplos:

```text
V1__schema.sql
V2__add_codigo_producto.sql
V3__add_fecha_recepcion_compra.sql
V4__create_nueva_tabla.sql
```

Cuando Spring Boot vuelva a iniciar, Flyway consulta `flyway_schema_history`.

Si la base de datos ya tiene:

```text
V1
```

pero encuentra:

```text
V2
```

Flyway ejecutará únicamente `V2`.

```text
Base de datos
V1 ✅

Migraciones
V1 ✅
V2 🆕

     ↓

Flyway ejecuta V2

     ↓

Base de datos
V1 ✅
V2 ✅
```

De esta forma todos los desarrolladores pueden mantener la misma estructura de base de datos.

---

# Dependencias

Las dependencias del backend están definidas en:

```text
pom.xml
```

No es necesario instalar manualmente Spring Boot ni cada una de sus dependencias.

Maven se encarga de descargarlas automáticamente.

El proyecto incluye:

```text
mvnw
mvnw.cmd
.mvn/
```

Estos archivos forman parte del **Maven Wrapper**.

---

# Ejecutar el backend

Una vez que:

- Java 25 está instalado.
- PostgreSQL está ejecutándose.
- `inventory_saas` fue creada y está vacía.
- `application.properties` fue creado y configurado.

El backend puede ejecutarse.

### Windows

```powershell
.\mvnw.cmd spring-boot:run
```

### Linux / macOS

```bash
./mvnw spring-boot:run
```

En la primera ejecución Maven descargará automáticamente las dependencias necesarias.

Después Spring Boot iniciará la aplicación y Flyway ejecutará las migraciones pendientes.

---

# Verificar la ejecución

Una conexión exitosa con PostgreSQL mostrará:

```text
HikariPool-1 - Start completed.
```

Cuando Flyway ejecute una migración nueva:

```text
Successfully applied 1 migration
```

Si todas las migraciones ya fueron ejecutadas:

```text
Schema "public" is up to date. No migration necessary.
```

Finalmente, cuando el backend esté funcionando:

```text
Tomcat started on port 8080
Started BackendApplication
```

Por defecto, el servidor se ejecuta en:

```text
http://localhost:8080
```