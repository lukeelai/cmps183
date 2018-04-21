import sqlite3
from bottle import error, route, run, debug, template, request, static_file, redirect
from datetime import datetime

conn = sqlite3.connect('todo.db') # Warning: This file is created in the current directory
conn.execute("CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY, task varchar(100) NOT NULL, description varchar(100), posted date, due date, modify date, status bool NOT NULL)")
conn.execute("INSERT INTO todo (task, description, posted, due, modify, status) VALUES ('Dishes', 'Do the dishes', '2018/02/20', '2018/02/28', '2018/02/20', 0)")
conn.execute("INSERT INTO todo (task, description, posted, due, modify, status) VALUES ('Homework', 'Finish my homework', '2018/02/25', '2018/02/28', '2018/02/25', 1)")
conn.execute("INSERT INTO todo (task, description, posted, due, modify, status) VALUES ('Vaccum', 'Vaccum the house', '2018/02/23', '2018/02/28', '2018/02/23', 0)")
conn.execute("INSERT INTO todo (task, description, posted, due, modify, status) VALUES ('Study', 'Study for midterm next week', '2018/02/21', '2018/03/11', '2018/02/21', 0)")
conn.execute("INSERT INTO todo (task, description, posted, due, modify, status) VALUES ('Cook', 'Make Dinner', '2018/02/28', '2018/02/28', '2018/02/28', 0)")
conn.execute("INSERT INTO todo (task, description, posted, due, modify, status) VALUES ('Tennis', 'Tennis courts on campus', '2018/02/28', '2018/03/11', '2018/02/28', 0)")
conn.commit()

@route('/index')
def indexx():
    return template('index')

@route('/list')
def todo_list():
    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT * FROM todo WHERE status IS NOT NULL")
    result = c.fetchall()
    c.close()
    output = template('todo', rows=result, count = 0, route = 8080)
    return output

@route('/new', method='GET')
def new_item():

    if request.GET.save:

        new = request.GET.task.strip()
        newDate = request.GET.notes.strip()
        due = request.GET.due.strip()

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()

        c.execute('''INSERT INTO todo (task, description, posted, due, modify, status) VALUES ("%s", "%s", "%s", "%s", "%s", 0);''' % (new, newDate, now, due, now))
        conn.commit()
        c.close()

        redirect("/list")
    else:
        return template('todo.tpl')

@route('/edit/<no:int>', method='GET')
def edit_item(no):
    if request.GET.save:
        edit = request.GET.task.strip()
        status = request.GET.status.strip()
        notes = request.GET.notes.strip()
        pDate = request.GET.posted.strip()
        dDate = request.GET.due.strip()
        mDate = request.GET.modified.strip()

        if status == 'done':
            status = 1
        else:
            status = 0

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("UPDATE todo SET task = ?, description = ?, posted = ?, due = ?, modify = ?, status = ? WHERE id LIKE ?", (edit, notes, pDate, dDate, mDate, status, no))
        conn.commit()

        redirect("/list")

    else:
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("SELECT task FROM todo WHERE id LIKE ?", (str(no),))
        cTask = c.fetchone()

        c.execute("SELECT description FROM todo WHERE id LIKE ?", (str(no),))
        cNotes = c.fetchone()
        
        c.execute("SELECT posted FROM todo WHERE id LIKE ?", (str(no),))
        cPosted = c.fetchone()

        c.execute("SELECT due FROM todo WHERE id LIKE ?", (str(no),))
        cDue = c.fetchone()

        now = ((str(datetime.now())).split(' ')[0]).split('-')[2] + '-' + ((str(datetime.now())).split(' ')[0]).split('-')[1] + '-' + ((str(datetime.now())).split(' ')[0]).split('-')[0]

        return template('edit_task', tasks=cTask, notess = cNotes, posteds = cPosted, duess = cDue, mdate = now, no=no)

@route('/item<item:re:[0-9]+>')
def show_item(item):
    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT task FROM todo WHERE id LIKE ?", (item,))
    result = c.fetchall()
    c.close()
    if not result:
        return 'This item number does not exist!'
    else:
        return 'Task: %s' % result[0]

@route('/help')
def help():
    return static_file('help.html', root='/path/to/file')


@route('/json<json:re:[0-9]+>')
def show_json(json):
    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT task FROM todo WHERE id LIKE ?", (json,))
    result = c.fetchall()
    c.close()

    if not result:
        return {'task': 'This item number does not exist!'}
    else:
        return {'task': result[0]}

@route('/delete/<id:int>')
def delete(id):
    c = conn.cursor()
    c.execute("DELETE FROM todo WHERE id=" + str(id))
    conn.commit()
    
    redirect("/list")

@error(403)
def mistake403(code):
    return 'The parameter you passed has the wrong format!'

@error(404)
def mistake404(code):
    return 'Sorry, this page does not exist!'

debug(True)
run(reloader = True)
