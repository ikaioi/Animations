# Animations

Este projeto foi criado com Xcode 13.1, Swift 5 e iOS 15.0.
Ele foi definido para iPhone e iPad

Fiz os ajustes necessários ao projeto inicial, defini os ícones e launch screen.
Usei um ícone simples para exemplo no app. Para criá-lo, usei um template do Photoshop para criação de ícones nos tamanhos exigidos pelo iOS, adicionei uma imagem qualquer e gerei os ícones em todos os tamanhos.

Sendo o foco do projeto a criação da interface e animações/transições para uma lista de imagens e a tela de detalhes, não usei nenhuma arquitetura específica no desenvolvimento.
Usei imagens e dados mock integrados ao projeto, sem nenhuma conexão externa.

São listadas imagens de cidades numa tableview, a qual tem uma animação na rolagem.
Eu adicionei a animação parecida com o exemplo do vídeo, mas evitei que a animação fosse aplicada quando a lista é rolada de baixo para cima - o que estava gerando um efeito estranho visualmente.
Ao clicar em alguma imagem, uma transição irá iniciar e levar o usuário até a tela de detalhes. 
Essa transição é feita duplicando os elementos da célular clicada, aumenta o tamanho da imagem até completar a tela inteira, e desloca os textos e imagem para os lugares corretos na segunda tela.
Ao sair da tela de detalhes, o efeito inverso da transição é aplicado.
Na transição de abertura da tela de detalhes, eu fiz a animação de deslizar para cima do texto inferior diretamente no DetailsViewController para mostrar outra forma de animação possível.

Finalmente, o app foi testado num iPhone físico para verificação de possíveis bugs. 