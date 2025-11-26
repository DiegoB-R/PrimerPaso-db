# Proyecto Integrador: PrimerPaso (Base de Datos)

Repositorio del modelado y scripts de la base de datos para el proyecto PrimerPaso, 
una plataforma de conexión entre estudiantes y empresas.

## Descripción

Este repositorio contiene:
* El script SQL para la creación de la base de datos en PostgreSQL.
* El diagrama Entidad-Relación (conceptual) del proyecto.
* El modelo relacional (físico) exportado desde pgAdmin.

## Versión Actual
* **Versión:** 1.
* **Fecha de Actualización:** 2/11/2025
* **Últimos cambios:**


*Implementación del sistema "Inbox": Se sustituyó la tabla simple de mensajes por un modelo de hilos de conversación (Tickets) entre Estudiantes y Empresas.

*Nueva estructura de mensajería: Creación de las tablas inbox, inbox_messages (mensajes del estudiante) e inbox_responses (respuestas de la empresa).

*Normalización de estados: Inclusión de la tabla statuses para gestionar el estado de los chats (Pendiente/Contestado) con asignación automática por defecto.

*Documentación del esquema: Se agregaron comentarios explicativos detallados ("Docstrings") a todas las tablas y relaciones del script SQL.

*Limpieza de esquema: Eliminación de tablas obsoletas (messages) y ajuste de relaciones foráneas.

Archivo: Primer Paso SQL/V1.2.sql
