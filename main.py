from fastapi import FastAPI
import uvicorn

app = FastAPI()

# Create list of jobs
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

# Get health check (root directory)
@app.get("/")
def root():
    return {"Health check" : "OK"}

# Get list of jobs
@app.get("/job")
def list_jobs():
    return jobs

# Get job by id
@app.get("/job/{job_id}")
def get_by_id(job_id):
    for job in jobs:
        if job["id"] == job_id:
            return job

if __name__ == "__main__":
   uvicorn.run(app, host="0.0.0.0", port=80)