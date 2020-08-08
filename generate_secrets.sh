#!/usr/bin/env bash
kubectl -n edx create secret generic edx-edx-config --dry-run=client --from-file=lms.yml=./config/lms.yml --from-file=cms.yml=./config/cms.yml --from-file=__init__.py=./config/__init__.py -o yaml | ./kubeseal --controller-namespace sealed-secrets --scope cluster-wide -o yaml > templates/secrets/edx.yaml

kubectl -n edx create secret generic edx-lms-settings --dry-run=client --from-file=production.py=./config/lms.settings.py --from-file=__init__.py=./config/__init__.py -o yaml | ./kubeseal --controller-namespace sealed-secrets --scope cluster-wide -o yaml > templates/secrets/lms_settings.yaml
kubectl -n edx create secret generic edx-cms-settings --dry-run=client --from-file=production.py=./config/cms.settings.py --from-file=__init__.py=./config/__init__.py -o yaml | ./kubeseal --controller-namespace sealed-secrets --scope cluster-wide -o yaml > templates/secrets/cms_settings.yaml

kubectl -n edx create secret generic edx-minio-env --dry-run=client --from-env-file=./config/minio.env -o yaml  | ./kubeseal --controller-namespace sealed-secrets --scope cluster-wide -o yaml > templates/secrets/minio.yaml
kubectl -n edx create secret generic edx-mongodb-env --dry-run=client --from-env-file=./config/mongodb.env -o yaml  | ./kubeseal --controller-namespace sealed-secrets --scope cluster-wide -o yaml > templates/secrets/mongodb.yaml
kubectl -n edx create secret generic edx-mysql-env --dry-run=client --from-env-file=./config/mysql.env -o yaml  | ./kubeseal --controller-namespace sealed-secrets --scope cluster-wide -o yaml > templates/secrets/mysql.yaml
