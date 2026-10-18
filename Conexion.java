package modelo;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/** La conexión se guarda en un método para usarla desde todos los formularios. */
public class Conexion {
    public static Connection abrir() throws SQLException {
        File archivo = new File("data/envios.db");
        if (!archivo.isFile()) {
            throw new SQLException("No se encuentra la base de datos.\nUbicación esperada: "
                    + archivo.getAbsolutePath());
        }
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException ex) {
            throw new SQLException("Falta la biblioteca SQLite JDBC en Libraries.", ex);
        }
        Connection conexion = DriverManager.getConnection("jdbc:sqlite:" + archivo.getAbsolutePath());
        try (Statement consulta = conexion.createStatement()) {
            consulta.execute("PRAGMA foreign_keys = ON");
            consulta.execute("PRAGMA busy_timeout = 5000");
        } catch (SQLException ex) {
            conexion.close();
            throw ex;
        }
        return conexion;
    }
}
