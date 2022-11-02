from fastapi import FastAPI
import uvicorn

# Create fastapi
app = FastAPI()

# Create list of jobs
jobs = [
    { 
        "id" : "1",
        "title" : "Cloud Engineer",
        "description" : "Container orchestration, build and maintain infrastructure"
    },{
        "id" : "2",
        "title" : "Cloud Developer",
        "description" : "Build applications in cloud, build infrastructure"
    },{
        "id" : "3",
        "title" : "DevOps Engineer",
        "description" : "Build and monitor infrastructure, cooperate with various departments"
    },{
        "id" : "4",
        "title" : "Project Manager",
        "description" : "Control development"
    },{
        "id" : "5",
        "title" : "CEO",
        "description" : "THE BIGGGGGGGGEST BOSS"
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

# Get job by ID
@app.get("/job/{job_id}")
def get_by_id(job_id):
    for job in jobs:
        if job["id"] == job_id:
            return job

# Run code with Python
if __name__ == "__main__":
   uvicorn.run(app, host="0.0.0.0", port=80)