## Steps

1. Create `Dockerfile` (see it in current directory)
2. Created `docker-compose.yml`
3. Run `docker-compose up -d`.
4. Check the `app2` container from the `app1`: `docker-compose exec app1 ping app2`
5. Check the `app1` container from `app2`: `docker-compose exec app2 ping app1`
