# Proyecto Integrador: PrimerPaso (Base de Datos)

Repositorio del modelado y scripts de la base de datos para el proyecto PrimerPaso, 
una plataforma de conexión entre estudiantes y empresas.

## Descripción

Este repositorio contiene:
* El script SQL para la creación de la base de datos en PostgreSQL.
* El diagrama Entidad-Relación (conceptual) del proyecto.
* El modelo relacional (físico) exportado desde pgAdmin.

## Versión Actual
* **Versión:** 1.1
* **Fecha de Actualización:** 25/11/2025
* **Últimos cambios:**
    * Refactorización completa del esquema utilizando UUIDs (`gen_random_uuid()`).
    * Normalización de usuarios: Tabla central `users` con roles, separada de `student_profiles` y `company_profiles`.
    * Nuevas tablas para `jobs`, `applications`, `saved_jobs` y `events`.
    * Inclusión del archivo `Primer Paso SQL/V1.1.sql`.
