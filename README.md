# infrastructure
Contains infrastructure as code for running demo app locally or in the cloud

At present tha applications consists of the following services:

![](images/infra.png)

## GraphQL API

Publically facing GraphQL API, the responsibility of this API is to expose internal RESTful and gRPC APIs to end user interfaces.

## Product API

RESTful product api allowing CRUD operations on the company products. This service is backed by a PostgreSQL database

## Payment Service

gRCP based payment service which handles customer payments. This service is backed by a PostgreSQL database and a Redis queue.

## Consul

Consul is used throughout the system, all service to service communication is secured using mTLS and Consul Connect

## Vault

Vault is used for secrets storage, dynamic databse credentials, and encryption as a service
