;; credenciais de acesso aos bancos de dados
(setq sql-mysql-options '("--ssl-mode=REQUIRED"))
 
;; Remove all default login parameters
(setq sql-postgres-login-params nil)
 
(setq sql-connection-alist
  '(
	("db"
	 (sql-product  'mysql)
	 (sql-database "")
	 (sql-server   "")
	 (sql-user     "leonardo.uchoa")
	 (sql-password "")
	 )
        ;; Localhost
	("localhost-psql" 
	 (sql-product 'postgres)
	 (sql-database "postgresql://leonardopedreira@localhost:5432/leonardopedreira")
	 )
        ;; Bases Homolog
	("hml-...."
	 (sql-product  'mysql)
	 (sql-server   "")
	 (sql-user     "")
	 (sql-password "")
	 )
	)
  )
