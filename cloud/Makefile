terraform-cloud:
ifndef TF_CLOUD_TOKEN
	$(error TF_CLOUD_TOKEN is undefined)
endif
	echo 'credentials "app.terraform.io" {' > /root/.terraformrc
	@echo "  token = \"$(TF_CLOUD_TOKEN)\"" >> /root/.terraformrc
	echo "}" >> /root/.terraformrc

products-db:
	PGHOST := $(shell terraform output db_endpoint)
	PGUSER := $(shell terraform output db_username)
	PGPASSWORD := $(shell terraform output db_password)
	PGSERVER := $(shell terraform output db_server)
	DB_NAME := $(shell terraform output db_name)
	@curl -o products.sql https://raw.githubusercontent.com/hashicorp-demoapp/product-api-go/master/database/products.sql
	@psql "host=$(PGHOST) port=5432 dbname=${DB_NAME} user=$(PGUSER)@$(PGSERVER) password=$(PGPASSWORD) sslmode=require" -a -f products.sql

kubeconfig:
	GOOGLE_REGION := $(shell terraform output google_location)
	CLUSTER_NAME := $(shell terraform output cluster_name)
	PGHOST := $(shell terraform output db_endpoint)
	PGUSER := $(shell terraform output db_username)
	PGPASSWORD := $(shell terraform output db_password)
	gcloud container clusters get-credentials $(CLUSTER_NAME) --region $(GOOGLE_REGION)
	@kubectl create secret generic postgres --from-literal=host=$(PGHOST) --from-literal=user=$(PGUSER) --from-literal=password=$(PGPASSWORD)

helm:
	helm upgrade --install -f helm/consul-values.yaml consul ./helm/consul-helm-0.16.2
	helm upgrade --install -f helm/vault-values.yaml vault ./helm/vault-helm-0.3.3

vault:
	kubectl create configmap setup --from-file=./scripts/setup_vault.sh --from-file=./scripts/products_policy.hcl || true
	kubectl apply -f ./k8s_config/tools.yml

conftest:
	cat tfplan.json | conftest test -p policy/ -

opa-test:
	opa test policy/opa -f pretty -v

opa-eval:
	opa eval --format pretty --data policy/opa --input tfplan.json --package main deny

clean:
	rm -f products.sql
	helm delete consul vault