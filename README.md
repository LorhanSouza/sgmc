# SGMC - Sistema de Gerenciamento de Moto Clube 🏍️

O **SGMC** é uma solução de backend desenvolvida em Java com Spring Boot, projetada para automatizar e organizar a gestão administrativa de Moto Clubes. O sistema permite o controle de membros, eventos, participações, frotas de motos e muito mais.

## 🚀 Tecnologias Utilizadas

Este projeto utiliza o que há de mais moderno no ecossistema Java:

*   **Java 21**: Linguagem base.
*   **Spring Boot 4.0.6**: Framework para agilidade e configuração simplificada.
*   **Spring Data JPA**: Abstração de persistência de dados.
*   **Hibernate 7.2**: Implementação ORM robusta.
*   **MySQL**: Banco de dados relacional usado em produção.
*   **H2 Database**: Banco de dados em memória para desenvolvimento e testes.
*   **Keycloak / Spring Security OAuth2**: Gerenciamento de identidade e controle de acesso baseado em JWT.
*   **Scalar**: Documentação interativa da API.
*   **JUnit 5 & Mockito**: Garantia de qualidade via testes automatizados.
*   **Lombok**: Redução de código boilerplate.

## 🔒 Segurança e Controle de Acesso (Keycloak)

O sistema integra o **Spring Security** atuando como um **OAuth2 Resource Server** com JWT para validação de tokens gerados pelo **Keycloak**. 

### Perfis de Acesso (Roles)
*   **`admin`**: Acesso total a todas as funcionalidades do sistema (visualização, criação, edição e exclusão de membros, sedes, motos e eventos).
*   **`diretoria`**: Acesso administrativo completo equivalente ao `admin`.
*   **`membro`**: Acesso do tipo *self-service*. O usuário com esse perfil só pode visualizar e alterar as suas próprias informações cadastrais, cadastrar/alterar suas próprias motos e realizar sua própria inscrição em eventos. O controle é feito comparando o e-mail presente no token JWT do Keycloak com o e-mail do recurso solicitado.

As regras de autorização são declaradas nos controladores usando anotações `@PreAuthorize` delegadas para o componente customizado de segurança `SgmcSecurity`.

### Documentação Pública
Os endpoints de documentação da API estão configurados para livre acesso (sem autenticação):
*   `/api/docs/index.html`
*   `/api/v3/api-docs`

## 🛠️ Funcionalidades Principais

### Gestão de Membros
*   Cadastro completo de membros com validações.
*   **Exclusão Lógica**: Sistema de inativação (campo `ativo`) que mantém o histórico dos dados.
*   Associação de membros a **Cargos** e **Sedes**.
*   Filtragem dinâmica de membros por status.

### Eventos e Participações
*   Criação e gestão de eventos.
*   Controle de presença e participações de membros em eventos.
*   Mapeamento complexo de chaves compostas para participações.

### Gestão de Frota
*   Cadastro de motos associadas a membros.
*   Controle de marcas, modelos e seguros.

## 🏁 Como Executar o Projeto

### Pré-requisitos
*   JDK 21 ou superior.
*   Maven 3.8+ instalado (ou use o `./mvnw` incluso).
*   MySQL 8.0 ou superior instalado.
*   Keycloak em execução no endereço `http://localhost:8089` (realm: `sgmc`).

### Passo a Passo
1.  Clone o repositório:
    ```bash
    git clone https://github.com/seu-usuario/sgmc.git
    ```
2.  Acesse a pasta do projeto:
    ```bash
    cd sgmc
    ```
3.  Execute a aplicação:
    ```bash
    ./mvnw spring-boot:run
    ```
4.  Acesse a documentação da API (Scalar):
    ```
    http://localhost:8080/api/docs/index.html
    ```

## 🧪 Rodando os Testes

Para garantir que tudo está funcionando corretamente:

```bash
./mvnw test
```

Os testes utilizam o padrão do **Spring Boot 4**, com `@MockitoBean` para simular as regras de segurança e banco de dados em memória, garantindo isolamento total de dependências externas (como o servidor físico do Keycloak).

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
*Desenvolvido para facilitar a gestão de paixão por duas rodas.* 🤘
