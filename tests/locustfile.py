import time

from locust import HttpUser, between, task


class QuickstartUser(HttpUser):
    wait_time = between(1, 5)

    @task(3)
    def hello_world(self):
        self.client.get("/", name="/index")

    @task(3)
    def view_items(self):
        for item_id in range(10):
            self.client.get(f"/items/{item_id}", name="/items")
            time.sleep(1)
