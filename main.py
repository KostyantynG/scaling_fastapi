from fastapi import FastAPI
import uvicorn

# Create fastapi
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
    },{
        "id" : "third",
        "title" : "DevOps Engineer",
        "description" : "Build and monitor infrastructure, cooperate with various departments"
    },{
        "id" : "fourth",
        "title" : "Project Manager",
        "description" : "Be a boss man"
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

# Run code with python
if __name__ == "__main__":
   uvicorn.run(app, host="0.0.0.0", port=80)