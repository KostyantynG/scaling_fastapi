from fastapi import FastAPI
import uvicorn

app = FastAPI()

jobs = [
    { 
        "id" : "first",
        "title" : "Cloud Engineer",
        "description" : "Container orchestration, build and maintain infrastructure"
    },{
        "id" : "second",
        "title" : "Cloud Developer",
        "description" : "Build applications in cloud, build infrastructure"
    }
    ]

@app.get("/")
def root():
    return {"Health check" : "OK"}

@app.get("/job")
def list_jobs():
    return jobs

@app.get("/job/{job_id}")
def get_by_id(job_id):
    for job in jobs:
        if job["id"] == job_id:
            return job

if __name__ == "__main__":
   uvicorn.run(app, port=5000)