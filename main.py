from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
import os

local_server=True
app = Flask(__name__, template_folder='templates')
app.secret_key=os.getenv("SECRET_KEY")

app.config['SQLALCHEMY_DATABASE_URI']=os.getenv("DATABASE_URL")

db=SQLAlchemy(app)



login_manager=LoginManager(app)
login_manager.login_view='login'

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))



class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(500))

class Patient(db.Model):
    pid=db.Column(db.Integer,primary_key=True)
    firstName=db.Column(db.String(50))
    lastName=db.Column(db.String(50))
    age=db.Column(db.Integer)
    gender=db.Column(db.String(10))
    blood=db.Column(db.String(10))
    email=db.Column(db.String(50))
    phno=db.Column(db.String(20))
    disease=db.Column(db.String(50))
    dept=db.Column(db.String(50))
    status=db.Column(db.String(50))
    date=db.Column(db.String(50),nullable=False)
    time=db.Column(db.String(50),nullable=False)

class Doctor(db.Model):
    did=db.Column(db.Integer,primary_key=True)            
    dFname=db.Column(db.String(50))
    dLname=db.Column(db.String(50))
    dept=db.Column(db.String(50))
    salary=db.Column(db.Integer)          
    docPhno=db.Column(db.String(20))

class Pharmacy(db.Model):
    tabid=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(50),unique=True)
    dept=db.Column(db.String(50))
    specification=db.Column(db.String(200))
    prize=db.Column(db.Integer)

class Trigr(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    pid=db.Column(db.Integer)
    firstName=db.Column(db.String(50))
    lastName=db.Column(db.String(50))
    email=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.String(50))




@app.route('/',methods=['POST','GET'])
def signup():
    if request.method == "POST":
        username=request.form.get("username")
        email=request.form.get("email")
        password=request.form.get("password")
        
        user=User.query.filter_by(email=email).first()
        if user:
            flash('Email already exist', 'danger')
            return render_template("signup.html")
        encpassword=generate_password_hash(password)
        new_user=User(username=username, email=email, password=encpassword)
        db.session.add(new_user)
        db.session.commit()
        return render_template("login.html")

    return render_template("signup.html")


@app.route('/login',methods=["POST","GET"])
def login():
    if request.method == "POST":
        username=request.form.get("username")
        email=request.form.get("email")
        password=request.form.get("password")

        user=User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password,password) and user.username==username:
            login_user(user)
            flash('','success')
            return redirect(url_for('index'))
        else:
            flash('Invalid credential', 'danger')
            return render_template("login.html")

    return render_template("login.html")


@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))


@app.route('/index')
def index():
    if not User.is_authenticated:
        return render_template('login.html')
    return render_template("index.html",username=current_user.username)


@app.route('/patient',methods=['POST','GET'])
def patient():
    with db.engine.connect() as conn:
        docs = conn.execute(text("SELECT DISTINCT dept FROM doctor")).fetchall()
    if request.method == "POST":
        firstName=request.form.get("firstName")
        lastName=request.form.get("lastName")	
        age=request.form.get("age")	
        gender=request.form.get("gender")	
        blood=request.form.get("blood")	
        email=request.form.get("email")	
        phno=request.form.get("phno")	
        disease=request.form.get("disease")	
        dept=request.form.get("department")	
        status=request.form.get("status")	
        date=request.form.get("date")	
        time=request.form.get("time")
        patient=Patient(firstName=firstName, lastName=lastName, age=age, gender=gender, blood=blood, email=email, phno=phno, disease=disease, dept=dept, status=status, date=date, time=time)
        db.session.add(patient)
        db.session.commit()
        flash("Registration completed successfully","success")
    return render_template("patient.html",docs=docs)


@app.route('/bookdetail')
def bookings():
    em=current_user.email
    with db.engine.connect() as conn:
        query = conn.execute(text("SELECT * FROM patient WHERE email=:em"), {"em": em}).fetchall()
        return render_template("bookdetail.html", query=query)


@app.route("/edit/<string:pid>",methods=['POST','GET'])
def edit(pid):
    with db.engine.connect() as conn:
        docs = conn.execute(text("SELECT DISTINCT dept FROM doctor")).fetchall()
    posts=Patient.query.filter_by(pid=pid).first()
    if request.method == "POST":
        firstName=request.form.get("firstName")
        lastName=request.form.get("lastName")	
        age=request.form.get("age")	
        gender=request.form.get("gender")	
        blood=request.form.get("blood")	
        email=request.form.get("email")	
        phno=request.form.get("phno")	
        disease=request.form.get("disease")	
        dept=request.form.get("department")	
        status=request.form.get("status")	
        date=request.form.get("date")	
        time=request.form.get("time")
        with db.engine.begin() as conn:
            query = conn.execute(text("UPDATE patient SET pid = :pid, firstName = :firstName, lastName = :lastName, age = :age, gender = :gender, blood = :blood, email = :email, phno = :phno, disease = :disease, dept = :dept, status = :status, date = :date, time = :time WHERE patient.pid = :pid"), {"pid":pid, "firstName": firstName,"lastName":lastName,"age":age,"gender":gender,"blood":blood,"email":email,"phno":phno,"disease":disease,"dept":dept,"status":status,"date":date,"time":time})
            db.session.commit()
        flash("Updated successfully","success")
        return redirect(url_for('bookings'))
    return render_template("edit.html",posts=posts,docs=docs)


@app.route("/delete/<string:pid>",methods=['POST','GET'])
def delete(pid):
    with db.engine.begin() as conn:
        query = conn.execute(text("DELETE FROM patient WHERE patient.pid=:pid"), {"pid": pid})
    flash("Your appointment removed","warning")
    return redirect(url_for('bookings'))


@app.route('/details')
def details():
    with db.engine.connect() as conn:
        posts = conn.execute(text("SELECT * FROM trigr WHERE trigr.email=:email"),{"email": current_user.email}).fetchall()
    # posts=Trigr.query.all()
    return render_template("trigers.html",posts=posts)


@app.route('/doctor',methods=['POST','GET'])
def doctor():
    if request.method == "POST":
        dFname=request.form.get("firstName")
        dLname=request.form.get("lastName")
        dept=request.form.get("department")
        salary=request.form.get("salary")
        docPhno=request.form.get("phno")
        doctor=Doctor(dFname=dFname, dLname=dLname, dept=dept, salary=salary, docPhno=docPhno)
        db.session.add(doctor)
        db.session.commit()
        flash("Doctor details updated","success")
        return redirect(url_for('doctor_details'))
    return render_template("doctor.html")


@app.route('/doctordetails')
def doctor_details():
    with db.engine.connect() as conn:
        result = conn.execute(text("SELECT * FROM doctor")).fetchall()
    return render_template("doctordetails.html",result=result)


@app.route("/deletedoc/<string:did>")
def deletedoc(did):
    with db.engine.begin() as conn:
        query = conn.execute(text("DELETE FROM doctor WHERE doctor.did=:did"), {"did": did})
    flash("Doctor removed","warning")
    return redirect(url_for('doctor_details'))


@app.route('/insertdoc')
def insert_doc():
    if current_user.email=="kowshikk606@gmail.com":
        return redirect(url_for('doctor'))
    return render_template('doctordetails.html')


@app.route('/deletetrgr/<string:tid>')
def deletetrgr(tid):
    with db.engine.begin() as conn:
        query=conn.execute(text("DELETE FROM trigr WHERE trigr.tid=:tid"),{"tid":tid})
    return redirect(url_for('details'))


@app.route('/pharmacy')
def pharmacy():
    with db.engine.connect() as conn:
        department = conn.execute(text("SELECT DISTINCT dept FROM doctor")).fetchall()
    
    results = []
    for i in department:
        with db.engine.connect() as conn:
            result = conn.execute(text("SELECT * FROM pharmacy WHERE dept=:i"),{"i":i[0]}).fetchall()
        results.append((i[0],result))
    return render_template("pharmacy.html", results=results)


@app.route('/medicine', methods=["POST"])
def medicine():
    tablets = request.form.getlist("tablet[]")
    total = 0
    query = []

    for tablet in tablets:
        with db.engine.connect() as conn:
            result = conn.execute(text("SELECT prize FROM pharmacy WHERE name=:name"), {"name": tablet}).fetchone()
            if result:
                price = result[0]
                query.append((tablet, price))
                total += price

    return render_template("invoice.html", query=query, total=total)

if __name__ == "__main__":
    app.run(debug=True)
