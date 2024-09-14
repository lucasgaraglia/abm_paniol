from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
import MySQLdb.cursors

app = Flask(__name__)

# Configuración de la base de datos MySQL
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'abm_database'
app.config['MYSQL_HOST'] = 'localhost'

mysql = MySQL(app)

# get categorias
@app.route('/categorias', methods=['GET'])
def get_categorias():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT id, nombre FROM categorias")
    categorias = cursor.fetchall()
    cursor.close()
    
    return jsonify(categorias), 200

# get subcategorias
@app.route('/subcategorias', methods=['GET'])
def get_subcategorias():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT id, nombre, categoria_id FROM subcategorias")
    subcategorias = cursor.fetchall()
    cursor.close()
    
    return jsonify(subcategorias), 200

# get consumibles
@app.route('/consumibles', methods=['GET'])
def get_consumibles():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT co.id, co.nombre, co.unidad, co.cantidad, co.subcategoria_id, sc.nombre as subcagetoria_nombre, ca.id as categoria_id, ca.nombre as categoria_nombre FROM consumibles co INNER JOIN subcategorias sc ON co.subcategoria_id = sc.id INNER JOIN categorias ca ON sc.categoria_id = ca.id")
    subcategorias = cursor.fetchall()
    cursor.close()
    
    return jsonify(subcategorias), 200

# get tipo herramientas

# get herramientas

# get 1 categoria

@app.route('/categoria', methods=['GET'])
def get_categoria():
    id = request.args.get('sub')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT id, nombre FROM categorias")
    categorias = cursor.fetchall()
    cursor.close()
    
    return jsonify(categorias), 200

# get 1 subcategoria

# get 1 consumible

# get 1 tipo herramienta

# get 1 herramienta

# crear categoria
@app.route('/categoria', methods=['POST'])
def add_categoria():
    data = request.json
    nombre = data['nombre']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO categorias (nombre) VALUES (%s)", (nombre))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Categoría creada exitosamente'}), 201

# crear subcategoria (pasando categoria)
@app.route('/subcategoria', methods=['POST'])
def add_subcategoria():
    data = request.json
    nombre = data['nombre']
    categoria_id = data['categoria_id']
    
    cursor = mysql.connection.cursor()
    cursor.execute(f"INSERT INTO subcategorias (nombre, categoria_id) VALUES (%s, %s)", (nombre, categoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Subcategoría agregada exitosamente'}), 201

# crear consumibles (en subcategoria)
@app.route('/consumible', methods=['POST'])
def add_consumible():
    data = request.json
    nombre = data['nombre']
    unidad = data['unidad']
    cantidad = data['cantidad']
    imagen = data['imagen']
    subcategoria_id = data['subcategoria_id']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO consumibles (nombre, unidad, cantidad, imagen, subcategoria_id) VALUES (%s, %s, %s, %s, %s)", (nombre, unidad, cantidad, imagen, subcategoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Consumible agregado exitosamente'}), 201

# crear tipo_herramienta (en subcategoria)
@app.route('/tipo-herramienta', methods=['POST'])
def add_tipo_herramienta():
    data = request.json
    nombre = data['nombre']
    subcategoria_id = data['subcategoria_id']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO tipos_herramienta (nombre, cantidad, disponibles, subcategoria_id) VALUES (%s, %s, %s, %s)", (nombre, 0, 0, subcategoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Consumible agregado exitosamente'}), 201

# alta de herramienta
@app.route('/herramienta', methods=['POST'])
def add_herramienta():
    data = request.json
    observaciones = data['observaciones']
    imagen = data['imagen']
    tipo_id = data['tipo_id']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO herramientas (observaciones, imagen, tipo_id) VALUES (%s, %s, %s)", (observaciones, imagen, tipo_id))
    
    # consulta para afectar a cantidad de tipo_herramienta
    cursor.execute("""
        UPDATE tipos_herramienta
        SET cantidad = cantidad + 1, disponibles = disponibles + 1
        WHERE id = %s
    """, (tipo_id,))
    mysql.connection.commit()
    cursor.close()
    
    
    
    return jsonify({'message': 'Alta exitosa de la herramienta'}), 201

# baja de herramienta (paso toda la info a bajas, y elimino el registro de herramientas)



# modificacion de categoria

# modificacion de subcategoria

# modificacion de tipo de herramienta

# modificacion de herramienta en especifico

# modificacion de consumible


# eliminar categoria CASCADE

# eliminar subcategoria CASCADE

# eliminar tipo_herramienta CASCADE

# eliminar consumible


if __name__ == '__main__':
    app.run(debug=True)

# agregar una nueva herramienta
# @app.route('/herramientas', methods=['POST'])
# def add_herramienta():
#     data = request.json
#     nombre = data['nombre']
#     tipo_id = data['tipo_id']
    
#     cursor = mysql.connection.cursor()
#     cursor.execute("INSERT INTO herramientas (nombre, tipo_id) VALUES (%s, %s)", (nombre, tipo_id))
#     mysql.connection.commit()
#     cursor.close()
    
#     return jsonify({'message': 'Herramienta agregada exitosamente'}), 201

# # obtener todas las herramientas
# @app.route('/herramientas', methods=['GET'])
# def get_herramientas():
#     cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
#     cursor.execute("SELECT * FROM herramientas")
#     herramientas = cursor.fetchall()
#     cursor.close()
    
#     return jsonify(herramientas)

# # actualizar una herramienta
# @app.route('/herramientas/<int:id>', methods=['PUT'])
# def update_herramienta(id):
#     data = request.json
#     nombre = data['nombre']
#     tipo_id = data['tipo_id']
    
#     cursor = mysql.connection.cursor()
#     cursor.execute("UPDATE herramientas SET nombre=%s, tipo_id=%s WHERE id=%s", (nombre, tipo_id, id))
#     mysql.connection.commit()
#     cursor.close()
    
#     return jsonify({'message': 'Herramienta actualizada exitosamente'})

# # eliminar una herramienta
# @app.route('/herramientas/<int:id>', methods=['DELETE'])
# def delete_herramienta(id):
#     cursor = mysql.connection.cursor()
#     cursor.execute("DELETE FROM herramientas WHERE id=%s", (id,))
#     mysql.connection.commit()
#     cursor.close()
    
#     return jsonify({'message': 'Herramienta eliminada exitosamente'})