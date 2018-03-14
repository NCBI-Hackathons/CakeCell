# Input: Valid model name
# Output: path to associated .yaml and .pkl files for detectron

import argparse
import sqlite3
#import wget
import subprocess

def create_db():
    conn = sqlite3.connect("models.db")
    db = conn.cursor()
    db.execute("CREATE TABLE models (name varchar(100), yaml_url varchar(255), pkl_url varchar(255), cached boolean);")
    
    conn.commit()
    conn.close()

def add_model(name,yaml_url,pkl_url):
    conn = sqlite3.connect("models.db")
    db = conn.cursor()
    db.execute("INSERT INTO models VALUES (?,?,?,?)",(name,yaml_url,pkl_url,False))
    
    conn.commit()
    conn.close()
    
def read_urls(name):
    conn = sqlite3.connect("models.db")
    db = conn.cursor()
    db.execute("SELECT * FROM models WHERE name=?",(name,))
    row = db.fetchone()
    #conn.commit()
    conn.close()
    return row[1:3]
    
def check_cached(name):
    return len(glob.glob("/shared_cache/"+name+".pkl"))>0

    
# TODO: implement this
def remove_cache(name):
    # if this model is in the cache, remove it
    if check_cached(name):
        pass
    
    
def load_to_cache(name):
    (yaml_url,pkl_url) = read_urls(name)
    #subprocess.call("wget -O /shared_cache/"+name+".yaml "+yaml_url,shell=True)
    subprocess.call("wget -O /shared_cache/"+name+".pkl "+pkl_url,shell=True)
    
    conn = sqlite3.connect("models.db")
    db = conn.cursor()
    db.execute("UPDATE models SET cached=? WHERE name=?",(True,name))
    conn.commit()
    conn.close()
    
def return_local_path(name):
    # check if we're in the cache
    if not check_cached(name):
        # need to get this model into the cache
        load_to_cache(name)
    # name is just model name
    return ("/shared_cache/"+name+".pkl")
    
def is_valid(name):
    conn = sqlite3.connect("models.db")
    db = conn.cursor()
    db.execute("SELECT COUNT(*) FROM models WHERE name=?",(name,))
    (result,)=db.fetchone()
    conn.close()
    return result>0

def parse_args():
    parser = argparse.ArgumentParser(description="Get model files with caching")
    
    parser.add_argument("modelname", metavar="modelname",help="Name of the model to load")
    
    return parser.parse_args()

def main():
    args = parse_args()
    
    name = args.modelname
    
    # check if this model name is valid
    if not is_valid(name):
        return 1
    
    # print the cached name
    print return_local_path(name)
    
    return 0
    
    

if __name__=="__main__":
    exit(main())
    