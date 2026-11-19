// Modelo C4 de EXEMPLO, em Structurizr DSL.
//
// Sistema fictício ("Plataforma Exemplo"): uma plataforma B2B multi-tenant com painel web, app
// móvel, API em monólito modular, serviço de relatórios em PDF e banco relacional. Nomes, domínios,
// fornecedores e topologia são genéricos; servem para mostrar o MÉTODO, não um produto.
//
// Fonte de verdade: ESTE arquivo. As visões derivam dele; os SVG em dda/diagramas/ são saída de
// build (scripts/gerar-diagramas.sh) e nunca se editam à mão.
//
// Convenções:
// - identificadores hierárquicos (exemplo.api, exemplo.db);
// - toda visão com autoLayout: o layout é gerado, não desenhado; por isso workspace.json, que
//   guarda layout manual, fica fora do controle de versão;
// - chave de visão em ASCII (vira nome de arquivo exportado);
// - a propriedade `codigo` de cada contêiner aponta para a raiz do código que o realiza (aqui,
//   caminhos ilustrativos de um monorepo fictício).
//
// Os domínios do negócio aparecem duas vezes, de propósito:
// - como ELEMENTOS próprios na visão `Dominios` (domínio é espaço do problema, não é contêiner);
// - como COMPONENTES da API (tag "Proposto"), para derivar as visões de componentes, de uso e de
//   integração. Premissa do exemplo: uma API só (monólito modular).

workspace "Plataforma Exemplo" "Modelo de exemplo de documentação de arquitetura como código: C4 em Structurizr DSL, DDA e RDA em Markdown, ArchiMate em PlantUML." {

    !identifiers hierarchical

    model {
        gestor = person "Gestor do cliente" "Administra a conta da empresa cliente: estrutura, usuários e ciclos de trabalho."
        analista = person "Analista" "Conduz a análise e acompanha os planos."
        executivo = person "Leitor executivo" "Lê painéis e relatórios."
        admin = person "Administrador da plataforma" "Operação da plataforma (todas as contas)."
        participante = person "Participante" "Responde às coletas pelo app móvel, a partir de um convite."

        exemplo = softwareSystem "Plataforma Exemplo" "Plataforma B2B multi-tenant: coleta de dados, análise, planos de ação e relatórios em PDF." {
            !docs dda
            !adrs rda madr

            web = container "Painel web" "Telas dos papéis da empresa cliente e do administrador. Servido como site estático por CDN." "React, Vite, TypeScript" "Navegador" {
                properties {
                    "codigo" "apps/web"
                }
            }
            app = container "App móvel" "Responde às coletas; abre pelo link do convite (deep link)." "Flutter, Dart" "Movel" {
                properties {
                    "codigo" "apps/mobile"
                }
            }
            api = container "API" "Autenticação, regras de negócio, isolamento por tenant, integrações e montagem dos dados dos relatórios." "Node.js, TypeScript, ORM" {
                properties {
                    "codigo" "services/api"
                }

                // Domínios representados como componentes da API (proposta do exemplo).
                coleta = component "Coleta de dados" "Convites, formulários e respostas; agregação com piso mínimo de participantes." "Módulo de domínio principal" "Proposto, Principal"
                analise = component "Análise" "Transforma o que foi coletado em achados priorizados, com apoio de IA." "Módulo de domínio principal" "Proposto, Principal"
                planos = component "Planos e acompanhamento" "Planos de ação, responsáveis, prazos, evidências e revisão." "Módulo de domínio principal" "Proposto, Principal"
                cadastro = component "Cadastro organizacional" "Empresa, unidades, áreas, grupos e pessoas." "Módulo de domínio de suporte" "Proposto, Suporte"
                atendimento = component "Atendimento" "Solicitações dos clientes e seu tratamento." "Módulo de domínio de suporte" "Proposto, Suporte"
                identidade = component "Identidade e acesso" "Usuário, papel, sessão, MFA." "Módulo genérico" "Proposto, Generico"
                privacidade = component "Privacidade e consentimento" "Termos, política e aceite." "Módulo genérico" "Proposto, Generico"
                auditoria = component "Registro de auditoria" "Quem fez o quê e quando; usado por todos." "Módulo genérico" "Proposto, Generico"
                notificacoes = component "Notificações" "Avisos por e-mail e por mensageria." "Módulo genérico" "Proposto, Generico"
            }
            relatorios = container "Serviço de relatórios" "Renderiza PDFs a partir dos dados que a API monta. Roda na mesma imagem da API, em porta interna." "Python, FastAPI" {
                properties {
                    "codigo" "services/reports"
                }
            }
            db = container "Banco de dados" "Sistema de registro. Isolamento por tenant com Row-Level Security; trilha de auditoria append-only." "PostgreSQL" "Banco" {
                properties {
                    "codigo" "services/api/db"
                }
            }
        }

        mensageria = softwareSystem "Provedor de mensageria" "Canal de conversa com os usuários (chat). O número é transporte, não identidade." "Externo"
        email = softwareSystem "Provedor de e-mail" "E-mail transacional (convites, avisos)." "Externo"
        objetos = softwareSystem "Armazenamento de objetos" "Arquivos e evidências por tenant." "Externo"
        ia = softwareSystem "Provedor de IA" "Modelo de linguagem e transcrição de voz, atrás de uma porta (adaptador trocável)." "Externo"
        sso = softwareSystem "Provedor de identidade corporativa" "SSO da empresa cliente (OIDC ou SAML). Planejado; ainda não integrado no exemplo." "Externo, Futuro"

        // Pessoas e o sistema
        gestor -> exemplo.web "Usa" "HTTPS"
        analista -> exemplo.web "Usa" "HTTPS"
        executivo -> exemplo.web "Usa" "HTTPS"
        admin -> exemplo.web "Usa" "HTTPS"
        participante -> exemplo.app "Responde pelo convite" "Deep link"
        gestor -> mensageria "Conversa com o assistente" "Chat"

        // Dentro do sistema
        exemplo.web -> exemplo.api "Chama" "JSON sobre HTTPS"
        exemplo.app -> exemplo.api "Chama" "JSON sobre HTTPS"
        exemplo.api -> exemplo.db "Lê e escreve" "SQL, com RLS"
        exemplo.api -> exemplo.relatorios "Pede o PDF" "HTTP interno"

        // Sistemas externos
        exemplo.api -> mensageria "Envia mensagens" "API REST"
        mensageria -> exemplo.api "Entrega as mensagens recebidas" "Webhook"
        exemplo.api -> email "Envia e-mail" "HTTPS"
        exemplo.api -> objetos "Guarda e lê arquivos" "SDK"
        exemplo.api -> ia "Chama o modelo e transcreve voz" "HTTPS"
        exemplo.api -> sso "Federa a autenticação (planejado)" "OIDC"

        // Domínios como componentes da API. Entre componentes, a seta cheia é "depende de".
        // Registro de auditoria e Identidade e acesso são usados por todos: só aparecem onde a relação é de domínio.
        exemplo.api.analise -> exemplo.api.coleta "Recebe os dados agregados" "Chamada em processo" "Dependencia"
        exemplo.api.planos -> exemplo.api.analise "Recebe os achados priorizados" "Chamada em processo" "Dependencia"
        exemplo.api.coleta -> exemplo.api.cadastro "Público e recortes" "Chamada em processo" "Dependencia"
        exemplo.api.analise -> exemplo.api.cadastro "Grupos analisados" "Chamada em processo" "Dependencia"
        exemplo.api.planos -> exemplo.api.cadastro "Responsáveis e áreas" "Chamada em processo" "Dependencia"
        exemplo.api.atendimento -> exemplo.api.cadastro "Empresa e solicitante" "Chamada em processo" "Dependencia"
        exemplo.api.privacidade -> exemplo.api.identidade "Titular do aceite" "Chamada em processo" "Dependencia"
        exemplo.api.coleta -> exemplo.api.notificacoes "Convites" "Chamada em processo" "Dependencia"
        exemplo.api.planos -> exemplo.api.notificacoes "Lembretes de prazo" "Chamada em processo" "Dependencia"
        exemplo.api.atendimento -> exemplo.api.notificacoes "Avisos de andamento" "Chamada em processo" "Dependencia"

        exemplo.web -> exemplo.api.coleta "Dispara e acompanha a coleta" "JSON sobre HTTPS"
        exemplo.web -> exemplo.api.analise "Revisa e aprova a análise" "JSON sobre HTTPS"
        exemplo.web -> exemplo.api.planos "Gerencia os planos" "JSON sobre HTTPS"
        exemplo.web -> exemplo.api.cadastro "Cadastra a estrutura" "JSON sobre HTTPS"
        exemplo.web -> exemplo.api.atendimento "Trata as solicitações" "JSON sobre HTTPS"
        exemplo.web -> exemplo.api.identidade "Entra e gerencia usuários" "JSON sobre HTTPS"
        exemplo.web -> exemplo.api.privacidade "Aceita termos e política" "JSON sobre HTTPS"
        exemplo.app -> exemplo.api.coleta "Envia as respostas" "JSON sobre HTTPS"

        exemplo.api.coleta -> exemplo.db "Lê e grava o seu dado" "SQL, com RLS"
        exemplo.api.analise -> exemplo.db "Lê e grava o seu dado" "SQL, com RLS"
        exemplo.api.planos -> exemplo.db "Lê e grava o seu dado" "SQL, com RLS"
        exemplo.api.cadastro -> exemplo.db "Lê e grava o seu dado" "SQL, com RLS"
        exemplo.api.atendimento -> exemplo.db "Lê e grava o seu dado" "SQL, com RLS"
        exemplo.api.identidade -> exemplo.db "Lê e grava o seu dado" "SQL, com RLS"
        exemplo.api.privacidade -> exemplo.db "Lê e grava o seu dado" "SQL, com RLS"
        exemplo.api.auditoria -> exemplo.db "Grava a trilha" "SQL, append-only"
        exemplo.api.notificacoes -> exemplo.db "Grava os envios" "SQL, com RLS"
        exemplo.api.analise -> exemplo.relatorios "Pede o PDF da análise" "HTTP interno"
        exemplo.api.planos -> exemplo.relatorios "Pede o PDF do plano" "HTTP interno"
        exemplo.api.planos -> objetos "Guarda as evidências" "SDK"
        exemplo.api.analise -> ia "Síntese e priorização" "HTTPS"
        exemplo.api.coleta -> ia "Transcreve respostas por voz" "HTTPS"
        exemplo.api.notificacoes -> email "Envia e-mail" "HTTPS"
        exemplo.api.notificacoes -> mensageria "Envia mensagens" "API REST"
        exemplo.api.identidade -> sso "Federa a autenticação (planejado)" "OIDC"

        // Mapa de domínios do negócio. Domínio é espaço do problema: estes elementos não são
        // contêineres nem componentes. A seta lê-se "depende de"; a do domínio vizinho é fato
        // registrado pela organização, sem integração.
        coleta = element "Coleta de dados" "Domínio principal" "Convites, formulários e respostas; agregação com piso mínimo de participantes." "Dominio, Principal"
        analise = element "Análise" "Domínio principal" "Achados priorizados a partir do que foi coletado." "Dominio, Principal"
        planos = element "Planos e acompanhamento" "Domínio principal" "Planos de ação, responsáveis, prazos, evidências e revisão." "Dominio, Principal"
        cadastro = element "Cadastro organizacional" "Domínio de suporte" "Empresa, unidades, áreas, grupos e pessoas." "Dominio, Suporte"
        atendimento = element "Atendimento" "Domínio de suporte" "Solicitações dos clientes e seu tratamento." "Dominio, Suporte"
        identidade = element "Identidade e acesso" "Domínio genérico" "Usuário, papel, sessão." "Dominio, Generico"
        privacidade = element "Privacidade e consentimento" "Domínio genérico" "Termos, política e aceite." "Dominio, Generico"
        auditoriaReg = element "Registro de auditoria" "Domínio genérico" "Quem fez o quê e quando." "Dominio, Generico"
        notificacoes = element "Notificações" "Domínio genérico" "Avisos por e-mail e por mensageria." "Dominio, Generico"
        rh = element "Gestão de pessoas do cliente" "Domínio vizinho" "Sistemas de RH da empresa cliente; fornece a estrutura e as pessoas." "Vizinho"

        analise -> coleta "Recebe os dados agregados" "" "Dependencia"
        planos -> analise "Recebe os achados priorizados" "" "Dependencia"
        coleta -> cadastro "Público e recortes" "" "Dependencia"
        analise -> cadastro "Grupos analisados" "" "Dependencia"
        planos -> cadastro "Responsáveis e áreas" "" "Dependencia"
        atendimento -> cadastro "Empresa e solicitante" "" "Dependencia"
        privacidade -> identidade "Titular do aceite" "" "Dependencia"
        rh -> cadastro "Fornece estrutura e pessoas (importação)" "" "Fato"

        producao = deploymentEnvironment "Producao" {
            navegador = deploymentNode "Navegador do usuário" "Onde o painel web executa." "Chrome, Safari, Firefox" {
                webInst = containerInstance exemplo.web
            }
            aparelho = deploymentNode "Aparelho do participante" "Onde o app executa; o convite abre o app pelo deep link." "Android ou iOS" {
                appInst = containerInstance exemplo.app
            }
            borda = deploymentNode "Borda" "Serviços de borda gerenciados." "CDN e DNS" {
                cdn = infrastructureNode "CDN / hospedagem estática" "Serve o bundle do painel e os arquivos de verificação do deep link." "CDN"
                dns = infrastructureNode "DNS" "Resolve os domínios do painel e da API." "DNS gerenciado"
            }
            nuvem = deploymentNode "Provedor de nuvem" "Uma conta, uma região." "Nuvem pública" {
                conteineres = deploymentNode "Serviço gerenciado de contêineres" "Ingress HTTPS externo; escala horizontal." "Containers gerenciados" {
                    imagem = deploymentNode "Imagem da aplicação" "Uma imagem: API e serviço de relatórios." "Docker" {
                        apiInst = containerInstance exemplo.api
                        relatoriosInst = containerInstance exemplo.relatorios
                    }
                }
                pg = deploymentNode "PostgreSQL gerenciado" "Sem endpoint público: rede privada; acesso de operação só pelo bastion." "PostgreSQL gerenciado" {
                    dbInst = containerInstance exemplo.db
                }
                bastion = deploymentNode "Bastion" "Acesso de operação manual ao banco, sob demanda." "VM Linux" {
                    tunel = infrastructureNode "Túnel SSH" "Abre uma porta local apontando para o banco." "SSH"
                }
                softwareSystemInstance objetos
                softwareSystemInstance ia
            }

            producao.borda.cdn -> producao.navegador.webInst "Entrega o bundle" "HTTPS"
            producao.borda.dns -> producao.borda.cdn "Aponta o domínio do painel" "DNS"
            producao.borda.dns -> producao.nuvem.conteineres.imagem.apiInst "Aponta o domínio da API" "DNS"
            producao.nuvem.bastion.tunel -> producao.nuvem.pg.dbInst "Acesso de operação manual" "SSH"
        }
    }

    views {
        // Layout: as visões são desenhadas pelo Graphviz a partir do PlantUML exportado. Em texto se
        // controla (1) o que entra em cada visão, (2) a direção e os espaçamentos do autoLayout e
        // (3) os skinparams do PlantUML. Visão com muitas setas saindo da mesma caixa fica ilegível
        // em qualquer layout automático: a resposta é dividir a visão.

        systemContext exemplo "Contexto" "Quem usa a Plataforma Exemplo e com que sistemas externos ela fala. Tracejado: planejado." {
            include *
            autoLayout lr 200 120
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=90"
            }
        }

        container exemplo "Conteineres" "Os cinco contêineres e quem os usa. As integrações externas estão na visão Integracoes." {
            include *
            exclude mensageria email objetos ia sso
            autoLayout lr 200 120
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=90"
            }
        }

        container exemplo "Integracoes" "A API e os sistemas externos com que ela fala, um por integração." {
            include exemplo.api mensageria email objetos ia sso gestor
            autoLayout lr 200 120
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=90"
            }
        }

        custom "Dominios" "Mapa de domínios do negócio" "Três domínios principais (roxo), dois de suporte (verde), quatro genéricos (cinza) e um domínio vizinho. Seta cheia: depende de. Tracejada: fato registrado pela organização, sem integração. Os genéricos são usados por todos; só a dependência de Privacidade aparece." {
            include coleta analise planos cadastro atendimento identidade privacidade auditoriaReg notificacoes rh
            autoLayout tb 160 110
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=80"
            }
        }

        component exemplo.api "DominiosComponentes" "Os domínios como componentes da API e as dependências entre eles." {
            include exemplo.api.coleta exemplo.api.analise exemplo.api.planos exemplo.api.cadastro exemplo.api.atendimento exemplo.api.identidade exemplo.api.privacidade exemplo.api.auditoria exemplo.api.notificacoes
            autoLayout tb 160 110
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=80"
            }
        }

        component exemplo.api "DominiosUso" "Quem usa cada componente de domínio (painel web e app móvel)." {
            include exemplo.web exemplo.app exemplo.api.coleta exemplo.api.analise exemplo.api.planos exemplo.api.cadastro exemplo.api.atendimento exemplo.api.identidade exemplo.api.privacidade
            autoLayout tb 160 110
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=80"
            }
        }

        component exemplo.api "DominiosIntegracoes" "O que cada componente de domínio usa fora da API (banco, relatórios e sistemas externos). As dependências entre componentes estão na visão DominiosComponentes." {
            include exemplo.api.coleta exemplo.api.analise exemplo.api.planos exemplo.api.cadastro exemplo.api.atendimento exemplo.api.identidade exemplo.api.privacidade exemplo.api.auditoria exemplo.api.notificacoes exemplo.db exemplo.relatorios mensageria email objetos ia sso
            exclude "relationship.tag==Dependencia"
            autoLayout lr 200 120
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=90"
            }
        }

        deployment exemplo producao "Producao" "Onde cada contêiner roda em produção (topologia genérica)." {
            include *
            autoLayout lr 200 120
            properties {
                "plantuml.skinparams" "nodesep=40,ranksep=90"
            }
        }

        styles {
            element "Person" {
                shape person
                background #1f3a5f
                color #ffffff
            }
            element "Software System" {
                background #2f6690
                color #ffffff
            }
            element "Container" {
                background #3a7ca5
                color #ffffff
            }
            element "Externo" {
                background #8d99ae
                color #ffffff
            }
            element "Banco" {
                shape cylinder
            }
            element "Navegador" {
                shape webBrowser
            }
            element "Movel" {
                shape mobileDevicePortrait
            }
            element "Component" {
                background #5fa8d3
                color #ffffff
            }
            element "Principal" {
                background #534AB7
                color #ffffff
            }
            element "Suporte" {
                background #0F6E56
                color #ffffff
            }
            element "Generico" {
                background #5F5E5A
                color #ffffff
            }
            element "Futuro" {
                border dashed
            }
            element "Proposto" {
                border dashed
            }
            element "Vizinho" {
                background #F1EFE8
                color #444441
                border dashed
            }
            relationship "Dependencia" {
                style solid
            }
            relationship "Fato" {
                style dashed
            }
        }
    }

    configuration {
        scope softwaresystem
    }
}
