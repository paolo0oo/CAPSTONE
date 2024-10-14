-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-10-09 16:12:47 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE administrador (
    id_admin   NVARCHAR2(30) NOT NULL,
    nombre     VARCHAR2(20 CHAR) NOT NULL,
    apellido   VARCHAR2(20 CHAR) NOT NULL,
    usuario_id NVARCHAR2(1) NOT NULL
);

CREATE UNIQUE INDEX administrador__idx ON
    administrador (
        usuario_id
    ASC );

ALTER TABLE administrador ADD CONSTRAINT administrador_pk PRIMARY KEY ( id_admin );

CREATE TABLE cliente (
    id_cliente NVARCHAR2(30) NOT NULL,
    nombre     VARCHAR2(30 CHAR) NOT NULL,
    apellido   VARCHAR2(30 CHAR) NOT NULL,
    usuario_id NVARCHAR2(30) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE compra (
    id_compra          NUMBER(30, 1) NOT NULL,
    tipocompra         VARCHAR2(30 CHAR) NOT NULL,
    cliente_id_cliente NVARCHAR2(30) NOT NULL,
    pago_id_pago       unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    compra_id          NUMBER NOT NULL,
    id_pago            NUMBER NOT NULL,
    id_cliente         NVARCHAR2(1) NOT NULL
);

CREATE UNIQUE INDEX compra__idx ON
    compra (
        pago_id_pago
    ASC );

ALTER TABLE compra ADD CONSTRAINT compra_pk PRIMARY KEY ( compra_id );

ALTER TABLE compra ADD CONSTRAINT compra_id_compra_un UNIQUE ( id_compra );

CREATE TABLE detalleventa (
    venta_id_venta       INTEGER NOT NULL,
    producto_id_producto NUMBER(2, 1) NOT NULL,
    tipocomprobante      VARCHAR2(20 CHAR) NOT NULL,
    seriecomprobante     VARCHAR2(7 CHAR) NOT NULL,
    numcomprobante       VARCHAR2(10 CHAR) NOT NULL,
    fecha_hora           DATE NOT NULL,
    impuesto             NUMBER(4, 2) NOT NULL,
    total_venta          NUMBER(11, 2) NOT NULL,
    estado               VARCHAR2(20 CHAR) NOT NULL,
    id_detalleventa      INTEGER NOT NULL,
    venta_id_pago        NUMBER(20, 1) NOT NULL
);

ALTER TABLE detalleventa
    ADD CONSTRAINT detalleventa_pk PRIMARY KEY ( venta_id_venta,
                                                 venta_id_pago,
                                                 producto_id_producto,
                                                 id_detalleventa );

CREATE TABLE factura (
    venta_id_venta               INTEGER NOT NULL,
    id_factura                   NVARCHAR2(30) NOT NULL,
    fechaemision                 DATE NOT NULL,
    ciudad                       NVARCHAR2(30) NOT NULL,
    giro                         NVARCHAR2(30) NOT NULL,
    monto                        NUMBER(30, 1) NOT NULL,
    venta_mediopago_pago_id_pago NUMBER(20, 1) NOT NULL
);

CREATE UNIQUE INDEX factura__idx ON
    factura (
        venta_id_venta
    ASC,
        venta_mediopago_pago_id_pago
    ASC );

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE mediopago (
    debito        VARCHAR2(30 CHAR) NOT NULL,
    credito       VARCHAR2(30 CHAR) NOT NULL,
    transferencia VARCHAR2(30 BYTE) NOT NULL,
    pago_id_pago  NUMBER(20, 1) NOT NULL
);

ALTER TABLE mediopago ADD CONSTRAINT mediopago_pk PRIMARY KEY ( pago_id_pago );

CREATE TABLE pago (
    id_pago                      NUMBER(20, 1) NOT NULL,
    tipopago                     NVARCHAR2(30) NOT NULL,
    venta_id_venta               INTEGER NOT NULL,
    compra_compra_id             NUMBER NOT NULL,
    id_pago1                     NUMBER NOT NULL,
    id_compra                    NUMBER NOT NULL,
    venta_mediopago_pago_id_pago NUMBER NOT NULL
);

CREATE UNIQUE INDEX pago__idx ON
    pago (
        compra_compra_id
    ASC );

CREATE UNIQUE INDEX pago__idxv1 ON
    pago (
        venta_id_venta
    ASC );

CREATE UNIQUE INDEX pago__idx ON
    pago (
        id_compra
    ASC );

CREATE UNIQUE INDEX pago__idxv2 ON
    pago (
        venta_id_venta
    ASC,
        venta_mediopago_pago_id_pago
    ASC );

ALTER TABLE pago ADD CONSTRAINT pago_pk PRIMARY KEY ( id_pago );

CREATE TABLE producto (
    id_producto            NUMBER(2, 1) NOT NULL,
    tipoproducto           NVARCHAR2(30) NOT NULL,
    precio                 NUMBER(6) NOT NULL,
    administrador_id_admin NVARCHAR2(30) NOT NULL,
    venta_id_venta         INTEGER NOT NULL,
    id_pago                NUMBER NOT NULL,
    id_admin               NVARCHAR2(1) NOT NULL
);

CREATE UNIQUE INDEX producto__idx ON
    producto (
        venta_id_venta
    ASC );

CREATE UNIQUE INDEX producto__idx ON
    producto (
        venta_id_venta
    ASC,
        id_pago
    ASC );

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE usuario (
    id                     NVARCHAR2(30) NOT NULL,
    nombre                 VARCHAR2(30 CHAR) NOT NULL,
    apellido               VARCHAR2(30 CHAR) NOT NULL,
    tipousuario            VARCHAR2(30 CHAR),
    administrador_id_admin unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    id_admin               NVARCHAR2(1) NOT NULL
);

CREATE UNIQUE INDEX usuario__idx ON
    usuario (
        administrador_id_admin
    ASC );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id );

CREATE TABLE venta (
    id_venta               INTEGER NOT NULL,
    tipoventa              VARCHAR2(30 CHAR) NOT NULL,
    fecha                  DATE NOT NULL,
    comprobante            VARCHAR2(30 CHAR) NOT NULL,
    detalleventa           VARCHAR2(30 CHAR) NOT NULL,
    pago_id_pago           unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    producto_id_producto   NUMBER(2, 1) NOT NULL,
    factura_id_factura     NVARCHAR2(30) NOT NULL,
    mediopago_pago_id_pago NUMBER(20, 1) NOT NULL,
    id_pago1               NUMBER NOT NULL
);

CREATE UNIQUE INDEX venta__idx ON
    venta (
        producto_id_producto
    ASC );

CREATE UNIQUE INDEX venta__idxv1 ON
    venta (
        pago_id_pago
    ASC );

CREATE UNIQUE INDEX venta__idx ON
    venta (
        factura_id_factura
    ASC );

ALTER TABLE venta ADD CONSTRAINT venta_pk PRIMARY KEY ( id_venta,
                                                        mediopago_pago_id_pago );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_usuario_fk FOREIGN KEY ( usuario_id )
        REFERENCES usuario ( id );

ALTER TABLE compra
    ADD CONSTRAINT compra_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE detalleventa
    ADD CONSTRAINT detalleventa_producto_fk FOREIGN KEY ( producto_id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE detalleventa
    ADD CONSTRAINT detalleventa_venta_fk FOREIGN KEY ( venta_id_venta,
                                                       venta_id_pago )
        REFERENCES venta ( id_venta,
                           mediopago_pago_id_pago );

ALTER TABLE factura
    ADD CONSTRAINT factura_venta_fk FOREIGN KEY ( venta_id_venta,
                                                  venta_mediopago_pago_id_pago )
        REFERENCES venta ( id_venta,
                           mediopago_pago_id_pago );

ALTER TABLE mediopago
    ADD CONSTRAINT mediopago_pago_fk FOREIGN KEY ( pago_id_pago )
        REFERENCES pago ( id_pago );

ALTER TABLE producto
    ADD CONSTRAINT producto_administrador_fk FOREIGN KEY ( administrador_id_admin )
        REFERENCES administrador ( id_admin );

ALTER TABLE venta
    ADD CONSTRAINT venta_factura_fk FOREIGN KEY ( factura_id_factura )
        REFERENCES factura ( id_factura );

ALTER TABLE venta
    ADD CONSTRAINT venta_mediopago_fk FOREIGN KEY ( mediopago_pago_id_pago )
        REFERENCES mediopago ( pago_id_pago );

CREATE SEQUENCE compra_compra_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER compra_compra_id_trg BEFORE
    INSERT ON compra
    FOR EACH ROW
    WHEN ( new.compra_id IS NULL )
BEGIN
    :new.compra_id := compra_compra_id_seq.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                            13
-- ALTER TABLE                             20
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   3
-- WARNINGS                                 0
