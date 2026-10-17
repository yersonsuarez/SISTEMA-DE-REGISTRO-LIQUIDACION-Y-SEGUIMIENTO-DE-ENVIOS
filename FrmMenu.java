package vista;

import controlador.ControladorMenu;
import modelo.Envio;
import modelo.Opcion;
import modelo.EstadoEnvio;

/** Formulario JFrame editable en la pestaña Diseño de Apache NetBeans. */
public class FrmMenu extends javax.swing.JFrame {
    private final ControladorMenu controlador = new ControladorMenu();


    public FrmMenu() {
        initComponents();
        setLocationRelativeTo(null);
        if (java.beans.Beans.isDesignTime()) return;
        verificarConexion();
    }

    private void verificarConexion() {
        try {
            int cantidad = controlador.contarEnvios();
            lblConexion.setText("SQLite conectado. Envíos registrados: " + cantidad);
        } catch (Exception ex) {
            lblConexion.setText("No se pudo conectar a SQLite.");
            javax.swing.JOptionPane.showMessageDialog(this, ex.getMessage(), "Revisar conexión", javax.swing.JOptionPane.ERROR_MESSAGE);
            btnEnvios.setEnabled(false); btnClientes.setEnabled(false);
            btnTarifas.setEnabled(false); btnSeguimiento.setEnabled(false);
        }
    }

    private void mostrarAcerca() {
        javax.swing.JOptionPane.showMessageDialog(this,
            "Sistema de Registro, Liquidación y Seguimiento de Envíos\n"
            + "Unidades Tecnológicas de Santander. II semestre 2026.\n\n"
            + "Profesor: Mag. Carlos Adolfo Beltrán Castro\n"
            + "Yerson Suárez Blanco. C.C. 1095935530\n"
            + "Daniela García Carvajal. C.C. 1005298104\n\n"
            + "Proyecto Java Swing con ventanas JFrame y base SQLite.",
            "Acerca del proyecto", javax.swing.JOptionPane.INFORMATION_MESSAGE);
    }

    private void salir() {
        int respuesta = javax.swing.JOptionPane.showConfirmDialog(this,
            "¿Desea salir del sistema?", "Salir", javax.swing.JOptionPane.YES_NO_OPTION);
        if (respuesta == javax.swing.JOptionPane.YES_OPTION) {
            javax.swing.JOptionPane.showMessageDialog(this,
                "La aplicación se cerrará. Los datos guardados permanecerán en SQLite.");
            controlador.cerrarAplicacion();
        }
    }


    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
        lblLogo = new javax.swing.JLabel();
        lblTitulo = new javax.swing.JLabel();
        lblSubtitulo = new javax.swing.JLabel();
        lblOpciones = new javax.swing.JLabel();
        btnEnvios = new javax.swing.JButton();
        btnClientes = new javax.swing.JButton();
        btnTarifas = new javax.swing.JButton();
        btnSeguimiento = new javax.swing.JButton();
        btnAcerca = new javax.swing.JButton();
        btnSalir = new javax.swing.JButton();
        lblConexion = new javax.swing.JLabel();
        lblIntegrantes = new javax.swing.JLabel();

        setDefaultCloseOperation(0);
        setTitle("Menú del proyecto de envíos");
        setPreferredSize(new java.awt.Dimension(650, 450));
        setResizable(false);
        getContentPane().setLayout(null);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                formWindowClosing(evt);
            }
        });
        lblLogo.setName("lblLogo");
        lblLogo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/vista/logo_envios.png")));
        getContentPane().add(lblLogo);
        lblLogo.setBounds(25, 20, 180, 52);
        lblTitulo.setName("lblTitulo");
        lblTitulo.setText("Registro de envíos");
        lblTitulo.setFont(new java.awt.Font("Dialog", 1, 20));
        getContentPane().add(lblTitulo);
        lblTitulo.setBounds(225, 22, 390, 30);
        lblSubtitulo.setName("lblSubtitulo");
        lblSubtitulo.setText("Liquidación y seguimiento con SQLite");
        getContentPane().add(lblSubtitulo);
        lblSubtitulo.setBounds(225, 57, 390, 22);
        lblOpciones.setName("lblOpciones");
        lblOpciones.setText("Seleccione una opción del menú");
        lblOpciones.setFont(new java.awt.Font("Dialog", 1, 14));
        getContentPane().add(lblOpciones);
        lblOpciones.setBounds(30, 105, 570, 24);
        btnEnvios.setName("btnEnvios");
        btnEnvios.setText("Gestión de envíos");
        btnEnvios.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnEnviosActionPerformed(evt);
            }
        });
        getContentPane().add(btnEnvios);
        btnEnvios.setBounds(30, 145, 280, 42);
        btnClientes.setName("btnClientes");
        btnClientes.setText("Clientes");
        btnClientes.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnClientesActionPerformed(evt);
            }
        });
        getContentPane().add(btnClientes);
        btnClientes.setBounds(335, 145, 280, 42);
        btnTarifas.setName("btnTarifas");
        btnTarifas.setText("Tarifas");
        btnTarifas.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnTarifasActionPerformed(evt);
            }
        });
        getContentPane().add(btnTarifas);
        btnTarifas.setBounds(30, 205, 280, 42);
        btnSeguimiento.setName("btnSeguimiento");
        btnSeguimiento.setText("Seguimiento");
        btnSeguimiento.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSeguimientoActionPerformed(evt);
            }
        });
        getContentPane().add(btnSeguimiento);
        btnSeguimiento.setBounds(335, 205, 280, 42);
        btnAcerca.setName("btnAcerca");
        btnAcerca.setText("Acerca del proyecto");
        btnAcerca.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAcercaActionPerformed(evt);
            }
        });
        getContentPane().add(btnAcerca);
        btnAcerca.setBounds(30, 265, 280, 42);
        btnSalir.setName("btnSalir");
        btnSalir.setText("Salir");
        btnSalir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSalirActionPerformed(evt);
            }
        });
        getContentPane().add(btnSalir);
        btnSalir.setBounds(335, 265, 280, 42);
        lblConexion.setName("lblConexion");
        lblConexion.setText("Comprobando conexión...");
        getContentPane().add(lblConexion);
        lblConexion.setBounds(30, 335, 585, 24);
        lblIntegrantes.setName("lblIntegrantes");
        lblIntegrantes.setText("Yerson Suárez Blanco y Daniela García Carvajal");
        lblIntegrantes.setFont(new java.awt.Font("Dialog", 0, 11));
        getContentPane().add(lblIntegrantes);
        lblIntegrantes.setBounds(30, 370, 585, 24);
        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnEnviosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEnviosActionPerformed
        controlador.abrirEnvios();
    }//GEN-LAST:event_btnEnviosActionPerformed

    private void btnClientesActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnClientesActionPerformed
        controlador.abrirClientes();
    }//GEN-LAST:event_btnClientesActionPerformed

    private void btnTarifasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnTarifasActionPerformed
        controlador.abrirTarifas();
    }//GEN-LAST:event_btnTarifasActionPerformed

    private void btnSeguimientoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSeguimientoActionPerformed
        controlador.abrirSeguimiento();
    }//GEN-LAST:event_btnSeguimientoActionPerformed

    private void btnAcercaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAcercaActionPerformed
        mostrarAcerca();
    }//GEN-LAST:event_btnAcercaActionPerformed

    private void btnSalirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSalirActionPerformed
        salir();
    }//GEN-LAST:event_btnSalirActionPerformed

    private void formWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosing
        salir();
    }//GEN-LAST:event_formWindowClosing

    /** Ejecutar archivo también permite probar este JFrame por separado. */
    public static void main(String[] args) {
        try { javax.swing.UIManager.setLookAndFeel(javax.swing.UIManager.getSystemLookAndFeelClassName()); }
        catch (Exception ex) { /* Se conserva la apariencia estándar. */ }
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override public void run() {
                new FrmMenu().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAcerca;
    private javax.swing.JButton btnClientes;
    private javax.swing.JButton btnEnvios;
    private javax.swing.JButton btnSalir;
    private javax.swing.JButton btnSeguimiento;
    private javax.swing.JButton btnTarifas;
    private javax.swing.JLabel lblConexion;
    private javax.swing.JLabel lblIntegrantes;
    private javax.swing.JLabel lblLogo;
    private javax.swing.JLabel lblOpciones;
    private javax.swing.JLabel lblSubtitulo;
    private javax.swing.JLabel lblTitulo;
    // End of variables declaration//GEN-END:variables
}
