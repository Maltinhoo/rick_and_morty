# 🛸 Desafio Técnico – Flutter Developer com Rick and Morty API

Este projeto foi desenvolvido como parte de um desafio técnico para a vaga de Flutter Developer, com o objetivo de criar uma aplicação completa, funcional, responsiva e bem estruturada, compatível com **mobile** e **web**, utilizando Flutter e consumindo a [Rick and Morty API](https://rickandmortyapi.com/).

---

## 🔍 Funcionalidades

### 1. Lista de Personagens
- Exibição dos personagens da série Rick and Morty.
- Lista paginada com carregamento infinito.

### 2. Busca
- Campo de pesquisa para filtrar personagens por nome.
- Debounce para evitar requisições excessivas.

### 3. Tela de Filtros
- Filtros por **gênero**, **espécie** e **status**.
- Aplicação de múltiplos filtros simultaneamente.

### 4. Responsividade
- Interface adaptável para diferentes tamanhos de tela.
- Funcionamento fluido em dispositivos móveis e navegadores web.

---

## 🛠️ Tecnologias e Pacotes Utilizados

- **Flutter 3.32.3**
- **[Rick and Morty API](https://rickandmortyapi.com/)** – REST API pública
- **[go_router](https://pub.dev/packages/go_router)**: Navegação declarativa moderna.
- **[get_it](https://pub.dev/packages/get_it)**: Injeção de dependência.
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: Gerenciamento de estado.
- **[auto_size_text](https://pub.dev/packages/auto_size_text)**: Textos adaptáveis.
- **[flutter_svg](https://pub.dev/packages/flutter_svg)**: Suporte a imagens SVG.
- **[cached_network_image](https://pub.dev/packages/cached_network_image)**: Cache de imagens.
- **[shimmer](https://pub.dev/packages/shimmer)**: Efeito esqueleto de carregamento.
- **[gap](https://pub.dev/packages/gap)**: Espaçamentos inteligentes na UI.
- **[oktoast](https://pub.dev/packages/oktoast)**: Sistema de toasts.
- **[dio](https://pub.dev/packages/dio)**: Cliente HTTP robusto.
- **[curl_logger_dio_interceptor](https://pub.dev/packages/curl_logger_dio_interceptor)**: Log elegante das requisições HTTP.
- **[infinite_scroll_pagination](https://pub.dev/packages/infinite_scroll_pagination)**: Scroll infinito com paginação.
- **[firebase_core](https://pub.dev/packages/firebase_core)**: Base para integração com Firebase (preparado para expansão futura).

---

## ▶️ Como Rodar o Projeto

```bash
# Clone o repositório
git clone https://github.com/SEU_USUARIO/flutter-rick-and-morty-app.git
cd flutter-rick-and-morty-app

# Instale as dependências
flutter pub get

# Para rodar no mobile (Android/iOS)
flutter run

# Para rodar no navegador (web)
flutter run -d chrome
```

### [https://rick-and-morty-2c88e.web.app/#/home](https://rick-and-morty-2c88e.web.app/#/home)
