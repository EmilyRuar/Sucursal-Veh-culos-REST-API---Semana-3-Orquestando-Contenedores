# Sucursal Vehículos REST API

API REST desarrollada con Spring Boot 3.2.4 y Java 17 para la gestión de vehículos en una sucursal.

## Tecnologías

- Java 17
- Spring Boot 3.2.4
- Spring Data JPA + Hibernate
- MySQL (AWS RDS)
- Apache Tomcat 10.1.23
- SpringDoc OpenAPI / Swagger UI 2.5.0
- Docker
- Maven

## Estructura del Proyecto

```
Sucursal_vehiculos/
├── src/main/java/com/vehiculos/VehiculosRest/
│   ├── controllers/
│   │   ├── InicioController.java       # GET / → estado de la API
│   │   └── VehiculoController.java     # GET /vehiculos
│   ├── models/
│   │   └── VehiculoModel.java          # Entidad JPA tabla "vehiculos"
│   ├── repositories/
│   │   └── IVehiculoRepository.java    # JpaRepository<VehiculoModel>
│   ├── services/
│   │   └── VehiculoService.java        # Lógica CRUD
│   ├── ServletInitializer.java
│   └── VehiculosRestApplication.java
├── src/main/java/Swagger/
│   └── SwaggerConfigurations.java      # Config OpenAPI
├── src/main/resources/
│   └── application.properties          # Datasource + Swagger
├── Dockerfile
├── docker-compose.yml                  # ← AGREGADO
├── .gitignore
└── pom.xml
```

## Configuración de Base de Datos

Editar `src/main/resources/application.properties`:

```properties
# Para entorno local:
spring.datasource.url=jdbc:mysql://localhost:3306/Sucursal?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrival=true
spring.datasource.username=root
spring.datasource.password=tu_password

# Para AWS RDS (configuración original):
# spring.datasource.url=jdbc:mysql://database-1.cqjjjo9bhovc.us-east-1.rds.amazonaws.com:3306/Sucursal?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrival=true
```

## Compilar el Proyecto

```bash
# Con Maven Wrapper (incluido en el proyecto)
./mvnw clean package        # Linux/macOS
mvnw.cmd clean package      # Windows

# O con Maven instalado
mvn clean package
```

El archivo WAR se genera en: `target/vehiculosBuild.war`

## Despliegue con Docker

```bash
# Opción 1: Solo la aplicación (requiere MySQL externo)
docker build -t vehiculos-api:1.0 .
docker run -d --name vehiculos-app -p 8080:8080 vehiculos-api:1.0

# Opción 2: Aplicación + MySQL juntos (recomendado para desarrollo)
docker-compose up -d
```

## Despliegue Manual en Tomcat

1. Copiar `target/vehiculosBuild.war` a la carpeta `webapps/` de Tomcat
2. Iniciar Tomcat
3. Acceder a `http://localhost:8080/vehiculosBuild/`

## Endpoints

| Método | URL | Descripción |
|--------|-----|-------------|
| GET | `/` | Estado de la API |
| GET | `/vehiculos` | Listar todos los vehículos |
| POST | `/vehiculos` | Crear vehículo |
| GET | `/vehiculos/{id}` | Obtener por ID |
| PUT | `/vehiculos/{id}` | Actualizar por ID |
| DELETE | `/vehiculos/{id}` | Eliminar por ID |

## Swagger UI

Una vez desplegada la aplicación:

```
http://localhost:8080/vehiculosBuild/swagger-ui/index.html
http://localhost:8080/vehiculosBuild/api-docs
```

## Script SQL — Crear Base de Datos

```sql
CREATE DATABASE IF NOT EXISTS Sucursal CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Sucursal;

CREATE TABLE IF NOT EXISTS vehiculos (
  id               BIGINT        NOT NULL AUTO_INCREMENT,
  marca            VARCHAR(255)  DEFAULT NULL,
  modelo           VARCHAR(255)  DEFAULT NULL,
  ano              INT           DEFAULT NULL,
  color            VARCHAR(255)  DEFAULT NULL,
  tipo_combustible VARCHAR(255)  DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Datos de prueba
INSERT INTO vehiculos (marca, modelo, ano, color, tipo_combustible) VALUES
  ('Toyota',    'Corolla', 2022, 'Blanco',   'Bencina'),
  ('Honda',     'Civic',   2021, 'Negro',    'Bencina'),
  ('Chevrolet', 'Spark',   2023, 'Rojo',     'Bencina'),
  ('Nissan',    'Leaf',    2023, 'Azul',     'Eléctrico'),
  ('Toyota',    'Hilux',   2022, 'Gris',     'Diesel');
```

## Actividad — Semana 3: Orquestando Contenedores

Documentación completa del proceso de despliegue disponible en:
`docs/Evidencia_Orquestando_Contenedores.docx`
