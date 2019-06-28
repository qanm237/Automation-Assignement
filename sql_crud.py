import pymysql
import json
def jsonfunction():
	f='/tmp/terraform.tfstate'
	with open(f, 'r') as file:
		d=json.loads(file.read())
	url=d["modules"]["outputs"]["fetch the endpointurl according to the name displayed in the json"] 
	name=d["modules"]["outputs"]["fetch the name according to the name displayed in the json"]
	password=d["modules"]["outputs"]["fetch the password according to the name displayed in the json"] 
	return url,name, password
def connection():
    url, name , password = jsonfunction()
    try:
	#enables connection to the database, using the endpoint provided by AWS rds
        conn = pymysql.connect(host=url,user=name,passwd=password,port=3306)
        print("connected.")
        return conn
    except Exception as e:
        print(e)
def main():
	# create a cursor object of the database
	db = connection()
	cursor = db.cursor()
	cursor.execute("DROP TABLE IF EXISTS EMPLOYEE")
	# Create operaration
	sql = """CREATE TABLE EMPLOYEE (
   		FIRST_NAME  CHAR(20) NOT NULL,
   		LAST_NAME  CHAR(20),
   		AGE INT,  
                Gender CHAR(1),
   		INCOME FLOAT )"""

	cursor.execute(sql)
	print("created table")
	cursor.execute("INSERT INTO EMPLOYEE(FIRST_NAME, LAST_NAME, AGE, Gender, INCOME) VALUES ('Vishal', 'Bisht', 22, 'M', 100)")
	cursor.execute("INSERT INTO EMPLOYEE(FIRST_NAME, LAST_NAME, AGE, Gender, INCOME) VALUES ('Austin', 'Dzousa', 21, 'M', 200)")
	cursor.execute("INSERT INTO EMPLOYEE(FIRST_NAME, LAST_NAME, AGE, Gender, INCOME) VALUES ('Akash', 'Mahale', 2, 'M', 300)")
	cursor.execute("Select * from  EMPLOYEE")
	results = cursor.fetchall()
	print(results)
if __name__=='__main__':
	main()
