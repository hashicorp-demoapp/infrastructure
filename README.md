# Infrastructure
Contains infrastructure as code for running the demo app locally or in the cloud.

At present the applications consists of the following components:

![](/images/infra-new.png)

## [FRONTEND](https://github.com/hashicorp-demoapp/frontend)

A React UI that interacts with the Public API.

## [PUBLIC API](https://github.com/hashicorp-demoapp/public-api)

A publically facing GraphQL API. The responsibility of this API is to expose internal RESTful and gRPC APIs including the Product API, the Payments Service, and a [Coffee Service](https://github.com/hashicorp-demoapp/coffee-service) (that is not shown) to end user interfaces.

## [Product API](https://github.com/hashicorp-demoapp/product-api-go)

A RESTful product API allowing CRUD operations on the company products. This service is backed by a [PostgreSQL database](https://github.com/hashicorp-demoapp/postgres).

## [Payments Service](https://github.com/hashicorp-demoapp/payments)

gRCP based payments service which handles customer payments. This service is backed by a PostgreSQL database or a Redis queue.

## Consul

Consul is used throughout the system, all service to service communication is secured using mTLS and Consul Connect.

## Vault

Vault is used for secrets storage, dynamic databse credentials, and encryption as a service. Encryption can be done in the Payments Service using either Vault's [Transit](https://www.vaultproject.io/docs/secrets/transit) or [Transform](https://www.vaultproject.io/docs/secrets/transform) secrets engines.
