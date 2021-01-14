# coding=utf-8
import sys
import flask as f
import sqlalchemy as db
import flask_bootstrap as fb


if len(sys.argv) != 2:
    sys.exit('dbstring not supplied.')
engine = db.create_engine(sys.argv[1])
app = f.Flask('python_ava')
fb.Bootstrap(app)

'''
SQL Structure
-- select imagem, titulo, descricao, link from aulas
-- select login, nome, privilegio, senha from usuarios
'''

texto_alunos = '''
<p><a href="/logout">Logout</a></p>
<p>Selecione sua aula abaixo, de forma virtual,
para iniciar a sua aprendizagem neste ambiente:</p>
'''

texto_convidados = '''
<p>Para ver a lista completa de aulas, você
precisa pagar sua mensalidade e fazer
<a href="/login">login<a/>.</p>
'''


def query(text):
    conn = engine.connect()
    res = conn.execute(text)
    res = res.fetchall()
    return res


def execsql(text):
    conn = engine.connect()
    return conn.execute(text)


@app.route('/', methods=['GET'])
def get_index():
    cookie_user = f.request.cookies.get('python_ava_user')
    cookie_priv = f.request.cookies.get('python_ava_priv')
    if cookie_user:
        aluno = [cookie_user, f' ({cookie_priv}) ']
        texto_intro = texto_alunos
        lista = query('select imagem, titulo, descricao, link from aulas')
    else:
        aluno = ['Visitante', '']
        lista = [(
            'img_0001.jpg',
            'Super Aula Teste',
            'Agende uma aula teste online. Vai ser incrível.',
            'mailto:aulateste@avada.not.exist'
        )]
        texto_intro = texto_convidados
    return f.render_template(
        'index.html',
        items=lista,
        student=aluno,
        intro_text=texto_intro,
    )


@app.route('/login', methods=['GET'])
def get_login():
    return f.render_template('/login.html', msg='')


@app.route('/login', methods=['POST'])
def post_login():
    lg = f.request.form['login'] or 'blank'
    pw = f.request.form['senha'] or 'blank'
    sql = f'''
    select
        login,
        nome,
        privilegio,
        senha
    from usuarios
    where login = '{lg}'
    and senha = '{pw}'
    '''
    result = query(sql)
    if len(result) > 0:
        redirect = f.redirect('/')
        r = f.make_response(redirect)
        r.set_cookie('python_ava_user', value=result[0][1])
        r.set_cookie('python_ava_priv', value=result[0][2])
        return r
    else:
        return f.render_template('/login.html', msg='Login incorreto!')


@app.route('/logout', methods=['GET'])
def get_logout():
    redirect = f.redirect('/')
    r = f.make_response(redirect)
    r.set_cookie('python_ava_user', '', expires=0)
    r.set_cookie('python_ava_priv', '', expires=0)
    return r


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=8080)
