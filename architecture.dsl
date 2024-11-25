workspace "Proyecto DeUna" { 
    model { 
        #Se ubican los elementos que se quiere que se visualicen del modelo C4 
        user = person "Usuario" { 
            #Quien utiliza el sistema o producto 
            tags "userperson" 
        } 
        deunaServices = softwareSystem "DeUna services" { 
            description "Sistema neobancario de servicios digitales" 
            tags "deunaservices" 
            coreService = container "core-service" { 
                technology "Java Springboot" 
                tags "core-service" 
                description "Servicio que se encarga de la transaccionabilidad de la APP" 
            } 
            coreServiceDatabase = container "core-service-db" { 
                technology "PostgreSQL" 
                description "Base de datos relacional para albergar información de las transacciones" 
                tags "database" 
            } 
            accountService = container "account-service" { 
                technology "Nestjs" 
                tags "deUna-service" 
                description "Servicio que se encarga del manejo de cuentas de ahorro e historial" 
            } 
            accountServiceDatabase = container "account-service-db" { 
                technology "PostgreSQL" 
                description "Base de datos relacional para albergar información de las cuentas de ahorro" 
                tags "database" 
            } 
            usersService = container "users-service" { 
                technology "Nestjs" 
                tags "deUna-service" 
                description "Servicio que guarde la información del usuario real" 
            } 
            usersServiceDatabase = container "users-service-db" { 
                technology "PostgreSQL" 
                description "Base de datos relacional para albergar información de los usuarios" 
                tags "database" 
            } 
            notificationService = container "notification-service" { 
                technology ".NET" 
                tags "deUna-service" 
                description "Servicio que nos permite notificar las operaciones que son vía sms, email y push-notification" 
            } 
            cacheDatabase = container "cache-database" { 
                technology "Redis" 
                description "Almacena temporalmente información del usuario para notificación" 
                tags "database" 
            } 
            coreService -> coreServiceDatabase "Almacenar transacciones" 
            coreService -> accountService "Obtiene las cuentas" 
            accountService -> accountServiceDatabase "Almacenar cuentas" 
            usersService -> usersServiceDatabase "Almacenar información del usuarios" 
            notificationService -> cacheDatabase "Almacenar información temporal del usuario para notificaciones" 
            notificationService -> usersService "Se requiere la información del usuario para notificar" 
            usersService -> accountService "Requiere información para realizar las operaciones del usuario" 
        } 
        pichinchaServices = softwareSystem "Pichincha services"{ 
            description "Sistema bancario con APIs del Bancho Pichincha" 
            tags "externalServices" 
        } 
        user -> deunaServices "Transferir y pagar con QR" 
        deunaServices -> pichinchaServices "Consumir servicios bancarios de la banca digital" 
    } 
    views { 
        #Son las opciones de visualización de la herramienta  
        systemContext "deunaServices" { 
            include * 
            autoLayout tb  
        } 
        container "deunaServices" "SoftwareSystem"{ 
            description "La vista de contenedores del sistema DeUna" 
            include *  
            autoLayout lr 
        } 
        styles { 
            #Son los estilos CSS de los elementos y no de las vistas 
            element "userperson"{ 
                shape person  
                background #5F4D75 
                color #FFFFFF 
            } 
            element "deunaservices" { 
                background #5F4D41 
                color #FFFFFF 
            } 
            element "externalServices" { 
                background #1F4F41 
                color #FFFFFF 
            } 
            element "core-service" { 
                background #F5435F 
                color #FFFFFF 
            } 
            element "deUna-service"{ 
                background #4C1D80 
                color #00DCAC 
            } 
            element "database" { 
                shape cylinder 
                background #1B1D80 
                color #00DCAC 
            } 
        } 
    } 
} 