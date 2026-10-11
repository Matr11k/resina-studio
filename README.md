# Nacent

Plataforma pessoal para orçamentos de impressão 3D em resina.

## Uso

Abra https://matr11k.github.io/resina-studio/ . A calculadora é a tela principal. Configure seus custos e crie itens nas tabelas de preparação STL e pós-processamento. Cada orçamento pode combinar tarefas por pedido ou por peça, com custos próprios.

**Finalizar orçamento** guarda todos os dados e os parâmetros usados no histórico. As configurações futuras não alteram os custos dos orçamentos anteriores. Também é possível guardar rascunhos, duplicar um pedido e imprimir para PDF.

Orçamentos enviados que passaram do último dia de validade aparecem automaticamente como **Expirado**. Marque **Aprovado** quando o negócio for fechado. Pedidos aprovados, em produção ou concluídos não expiram.

## Arquitetura

`index.html` reúne toda a interface e o código da aplicação. GitHub Pages hospeda o site; Supabase Auth e PostgreSQL guardam os dados online, com políticas RLS por proprietário definidas em `schema.sql`.

No código, `cloudConfig` contém somente a URL do projeto e a chave **publishable/anon**. Nunca incluir chaves `service_role` ou `secret`, senhas, clientes ou orçamentos no repositório.

Enquanto o banco não estiver configurado, o modo demonstração é explicitamente local e não sincroniza aparelhos. Não há fallback silencioso para armazenamento local quando o banco online falha.

## Validação inicial

Verificados cálculos de referência, lotes independentes, tarefas por peça, lucro no preço escolhido, validade e preservação do histórico. Testados no navegador: criação de itens de serviços, finalização de dois orçamentos, reabertura e visualização em largura de celular.

O armazenamento online e o isolamento dos usuários precisam ser validados depois de configurar o Supabase.

## Referências

- https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site
- https://supabase.com/docs/guides/database/postgres/row-level-security
