import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:biqueiras/components/ViewSwitcher.dart';

enum PageStatus { normal, violada, descarregar }

enum CardStatus { normal, violado, desligado }

enum ButtonStatus { active, available, unavailable }

class BiqueirasPage extends StatefulWidget {
  final PageStatus initialPageStatus;

  const BiqueirasPage({super.key, required this.initialPageStatus});

  @override
  State<BiqueirasPage> createState() => _BiqueirasPageState();
}

class _BiqueirasPageState extends State<BiqueirasPage> {
  bool _isGridView = true;

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  late PageStatus _pageStatus;
  List<CardStatus> cardStatuses = [
    CardStatus.normal,
    CardStatus.normal,
    CardStatus.normal,
    CardStatus.normal,
    CardStatus.normal,
    CardStatus.normal,
    CardStatus.normal,
    CardStatus.normal,
  ];

  @override
  void initState() {
    super.initState();
    _pageStatus = widget.initialPageStatus;
    _checkPageStatus();
  }

  void _onReorder(ReorderedListFunction reorderedListFunction) {
    setState(() {
      cardStatuses = reorderedListFunction(cardStatuses) as List<CardStatus>;
    });
  }

  void _checkPageStatus() {
    final hasViolado = cardStatuses.contains(CardStatus.violado);
    setState(() {
      _pageStatus = hasViolado ? PageStatus.violada : PageStatus.normal;
    });
  }

  void _updateCardStatus(int index, CardStatus newStatus) {
    setState(() {
      cardStatuses[index] = newStatus;
      _checkPageStatus();
    });
  }

  void _descarregarBiqueiras() {
    setState(() {
      // Set all cards to desligado
      for (int i = 0; i < cardStatuses.length; i++) {
        cardStatuses[i] = CardStatus.desligado;
      }
      _pageStatus = PageStatus.descarregar;
    });
  }

  void _reativarBiqueiras() {
    setState(() {
      // Set all cards to desligado
      for (int i = 0; i < cardStatuses.length; i++) {
        cardStatuses[i] = CardStatus.normal;
      }
      _pageStatus = PageStatus.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardWidgets = List.generate(
      cardStatuses.length,
      (index) => BiqueiraCard(
        key: Key('card_$index'), // Unique key for each card
        index: index + 1,
        cardStatus: cardStatuses[index],
        onStatusChanged: (newStatus) {
          _updateCardStatus(index, newStatus);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: Stack(
        children: [
          Positioned(
            top: -200,
            right: -30,
            child: Container(
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(250),
                boxShadow: [
                  BoxShadow(
                    color:
                        _pageStatus == PageStatus.violada
                            ? Colors.red
                            : _pageStatus == PageStatus.descarregar
                            ? Color.fromRGBO(57, 73, 106, 0.4)
                            : Color.fromRGBO(13, 186, 26, 1),
                    blurRadius: 100,
                    spreadRadius: 100,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 32.0, 18.0, 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 36.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Minhas biqueiras",
                          style: TextStyle(
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w700,
                            fontSize: 26.0,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),

                      _pageStatus == PageStatus.violada
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.0),
                            Text(
                              "Para sua segurança, recomendamos que você entre em contato com a força policial mais próxima e a transportadora.",
                              style: TextStyle(fontSize: 14.0, color: Colors.white, height: 1.2),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),

                      SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: ViewSwitcher(
                          isGridView: _isGridView,
                          onToggle: (bool value) {
                            setState(() {
                              _isGridView = value;
                            });
                          },
                        ),
                      ),
                      Expanded( // This will take all remaining space
                        child: _isGridView
                          ? ReorderableBuilder(
                              scrollController: _scrollController,
                              onReorder: _onReorder,
                              children: cardWidgets,
                              builder: (children) {
                                return GridView(
                                  key: _gridViewKey,
                                  controller: _scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 8), // Small top padding only for grid
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6,
                                    mainAxisExtent: 60,
                                  ),
                                  children: children,
                                );
                              },
                            )
                          : ReorderableListView(
                              onReorder: (int oldIndex, int newIndex) {
                                setState(() {
                                  if (oldIndex < newIndex) {
                                    newIndex -= 1;
                                  }
                                  final CardStatus item = cardStatuses.removeAt(oldIndex);
                                  cardStatuses.insert(newIndex, item);
                                });
                              },
                              padding: EdgeInsets.only(top: 8, bottom: 6), // Consistent top padding
                              children: [
                                for (var i = 0; i < cardWidgets.length; i++)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: i < cardWidgets.length - 1 ? 6.0 : 0),
                                    key: ValueKey(cardWidgets[i]),
                                    child: cardWidgets[i],
                                  ),
                              ],
                            ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                      child: Button(
                        buttonStatus:
                            _pageStatus == PageStatus.violada
                                ? ButtonStatus.unavailable
                                : _pageStatus == PageStatus.descarregar
                                ? ButtonStatus.active
                                : ButtonStatus.available,
                        onPressed:
                            _pageStatus == PageStatus.normal
                                ? _descarregarBiqueiras
                                : _pageStatus == PageStatus.descarregar
                                ? _reativarBiqueiras
                                : null,
                      ),
                    ),
                    SizedBox(height: 16,),
                    SizedBox(
                      height: 45.0,
                      child: Text.rich(
                        TextSpan(
                          text: '',
                          children: [
                            if (_pageStatus == PageStatus.normal) ...[
                              TextSpan(text: 'Essa ação '),
                              TextSpan(
                                text: 'desabilita o sistema de fraude',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(text: ' sendo apenas recomendada caso as biqueiras precisem ser abertas em uma situação de segurança.'),
                            ] else if (_pageStatus == PageStatus.violada) ...[
                              TextSpan(text: 'Essa ação não está disponível porque há uma biqueira violada. '),
                            ] else ...[
                              TextSpan(text: 'Essa ação '),
                              TextSpan(
                                text: 'reativa o sistema de fraude',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(text: ' após o descarregamento ter sido finalizado.'),
                            ]
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          height: 1.2,
                          color: Color.fromRGBO(1, 1, 1, .4),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

////////////// Cards

class BiqueiraCard extends StatelessWidget {
  final CardStatus cardStatus;
  final Function(CardStatus)? onStatusChanged;
  final int index;

  const BiqueiraCard({
    super.key,
    required this.cardStatus,
    this.onStatusChanged,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    String statusText;
    Color statusColor;
    Color backgroundColor;
    Color titleColor;

    switch (cardStatus) {
      case CardStatus.normal:
        cardColor = Color.fromRGBO(13, 186, 26, 1);
        statusText = "Segura";
        backgroundColor = Colors.white;
        titleColor = Color.fromRGBO(0, 0, 0, 1);
        statusColor = Color.fromRGBO(0, 0, 0, 0.6);
        break;
      case CardStatus.violado:
        cardColor = Colors.red;
        statusText = "violada";
        backgroundColor = Colors.white;
        titleColor = Colors.red;
        statusColor = Colors.red;
        break;
      case CardStatus.desligado:
        cardColor = Color.fromRGBO(30, 30, 30, 0.28);
        statusText = "Desligada";
        backgroundColor = Color.fromRGBO(243, 243, 243, 1);
        titleColor = Color.fromRGBO(0, 0, 0, 0.6);
        statusColor = Color.fromRGBO(0, 0, 0, 0.24);
        break;
    }

    return GestureDetector(
      onTap: () {
        if (onStatusChanged != null && cardStatus != CardStatus.desligado) {
          // Cycle through statuses when tapped, but skip if already desligado
          final newStatus =
              CardStatus.values[(cardStatus.index + 1) %
                  (CardStatus.values.length - 1)];
          onStatusChanged!(newStatus);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(1, 1, 1, .08), width: 1), 
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, .08),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    cardStatus == CardStatus.violado 
                    ? Positioned(
                        bottom: 0,
                        left: 30, // ajusta conforme necessário
                        child: SvgPicture.asset(
                          'assets/icons/warning.svg',
                          height: 20,
                          width: 22.33,
                        ),
                      )
                    : SizedBox.shrink(),
                  ],
                ),

              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 2.0,
                children: [
                  Text(
                    "Biqueira",
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1,
                      fontWeight: 
                        cardStatus == CardStatus.violado
                              ? FontWeight.w700
                              : FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize:
                        cardStatus == CardStatus.violado
                              ? 14
                              : 12,
                      height: 1.16,
                      fontWeight:
                          cardStatus == CardStatus.violado
                              ? FontWeight.w700
                              : FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////// Botões

class Button extends StatelessWidget {
  final ButtonStatus buttonStatus;
  final VoidCallback? onPressed;

  const Button({super.key, required this.buttonStatus, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    bool isDisabled = false;
    String buttonText;

    switch (buttonStatus) {
      case ButtonStatus.active:
        backgroundColor = Color(0xFF0DBA1A);
        foregroundColor = Color.fromRGBO(255, 255, 255, 1);
        buttonText = "Reativar biqueiras";
        break;
      case ButtonStatus.available:
        backgroundColor = Colors.white;
        foregroundColor = Color.fromRGBO(0, 0, 0, 1);
        buttonText = "Descarregar";
        break;
      case ButtonStatus.unavailable:
        backgroundColor = Colors.white;
        foregroundColor = Color.fromRGBO(0, 0, 0, 1);
        buttonText = "Descarregar";
        isDisabled = true;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 12,
                color: Color.fromRGBO(0, 0, 0, .14),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: TextButton(
              onPressed: isDisabled ? null : onPressed,
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  foregroundColor,
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  backgroundColor,
                ),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 16),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                  buttonStatus == ButtonStatus.active
                    ? FontWeight.w600 
                    : FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
